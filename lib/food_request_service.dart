import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'food_request.dart'; // Ensure this path is correct
import 'food.dart'; // Ensure this path is correct

class FoodRequestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  // Method to add a food request
  Future<void> notifyUser(String userId, String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your_channel_id', 'Your Channel Name',
        channelDescription: 'Your Channel Description',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false);
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await _notificationsPlugin.show(0, title, body, platformChannelSpecifics);
  }

  Future<FoodRequest> addFoodRequest(FoodRequest request) async {
    try {
      // Add the food request to Firestore
      DocumentReference docRef = await _firestore.collection('foodRequests').add(request.toMap());
      request.id = docRef.id;

      // Fetch the food document directly to get the donor ID
      DocumentSnapshot foodDoc = await _firestore.collection('foods').doc(request.foodId).get();

      if (foodDoc.exists && foodDoc.data() != null) {
        Map<String, dynamic> foodData = foodDoc.data() as Map<String, dynamic>;
        String donorId = foodData['userId']; // Retrieve donor ID

        // Notify the donor about the new food request
        await notifyUser(donorId, 'New Food Request', 'A new food request for ${request.foodName} has been created.');
      } else {
        throw Exception('Food document does not exist or is empty for ID: ${request.foodId}');
      }

      return request; // Return the request with the ID
    } catch (e) {
      throw Exception('Error adding food request: $e');
    }
  }


  // Method to retrieve all food requests for a specific user
  Stream<List<FoodRequest>> getUserFoodRequests(String userId) {
    return _firestore
        .collection('foodRequests')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FoodRequest.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });

  }

  // Method to retrieve all food requests (for donor notifications)
  Stream<List<FoodRequest>> getAllFoodRequests() {
    return _firestore
        .collection('foodRequests')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FoodRequest.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  // Method to retrieve all food requests for a specific donor
  Stream<List<FoodRequest>> getDonorFoodRequests(String donorId) {
    return _firestore
        .collection('foods')
        .where('userId', isEqualTo: donorId) // Get foods donated by the donor
        .snapshots()
        .asyncMap((foodSnapshot) async {
      // Extract food IDs
      List<String> foodIds = foodSnapshot.docs.map((doc) => doc.id).toList();

      // Fetch food requests matching those food IDs
      if (foodIds.isEmpty) {
        return []; // Return an empty list if there are no food IDs
      }

      final requestSnapshot = await _firestore
          .collection('foodRequests')
          .where('foodId', whereIn: foodIds) // Match food requests with the food IDs
          .get(); // Use get() to fetch the documents

      return requestSnapshot.docs
          .map((doc) => FoodRequest.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }


  // Method to cancel (delete) a food request
  Future<bool> cancelFoodRequest(String requestId) async {
    try {
      await _firestore.collection('foodRequests').doc(requestId).delete();
      return true; // Return true if the deletion was successful
    } catch (e) {
      print('Error deleting food request: $e');
      return false; // Return false if there was an error
    }
  }

  // Method to approve a food request
  Future<bool> approveFoodRequest(String requestId) async {
    try {
      DocumentSnapshot requestDoc = await _firestore.collection('foodRequests').doc(requestId).get();
      FoodRequest request = FoodRequest.fromMap(requestDoc.data() as Map<String, dynamic>, requestId);

      await _firestore.collection('foodRequests').doc(requestId).update({'status': 'approved'});
      await notifyUser(request.userId, 'Request Approved', 'Your request for food has been approved.');
      return true; // Return true if the update was successful
    } catch (e) {
      print('Error approving food request: $e');
      return false; // Return false if there was an error
    }
  }

  // Method to decline a food request
  Future<bool> declineFoodRequest(String requestId) async {
    try {
      DocumentSnapshot requestDoc = await _firestore.collection('foodRequests').doc(requestId).get();
      FoodRequest request = FoodRequest.fromMap(requestDoc.data() as Map<String, dynamic>, requestId);

      await _firestore.collection('foodRequests').doc(requestId).update({'status': 'declined'});
      await notifyUser(request.userId, 'Request Declined', 'Your request for food has been declined.');
      return true; // Return true if the update was successful
    } catch (e) {
      print('Error declining food request: $e');
      return false; // Return false if there was an error
    }
  }

  Future<bool> updateFoodRequest(String requestId, double quantity, String location, String contact) async {
    try {
      await _firestore.collection('foodRequests').doc(requestId).update({
        'quantity': quantity,
        'location': location,
        'contact': contact,
      });
      return true; // Return true if the update was successful
    } catch (e) {
      print('Error updating food request: $e');
      return false; // Return false if there was an error
    }
  }
}
