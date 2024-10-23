import 'package:cloud_firestore/cloud_firestore.dart';
import 'food.dart';

class FoodService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<DocumentReference> addFood(Food food) {
    // Add food to Firestore and return the document reference
    return _db.collection('foods').add(food.toMap());
  }

  Stream<List<Food>> getFoods() {
    return _db.collection('foods').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Food.fromMap(doc.data() as Map<String, dynamic>)..id = doc.id; // Set the ID
      }).toList();
    });
  }

  Future<void> requestFood(String foodId, int requestedQuantity) async {
    DocumentReference foodRef = _db.collection('foods').doc(foodId);
    await _db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(foodRef);
      if (!snapshot.exists) throw Exception("Food does not exist!");

      Food food = Food.fromMap(snapshot.data() as Map<String, dynamic>);
      if (food.quantity < requestedQuantity) throw Exception("Not enough quantity!");

      food.quantity -= requestedQuantity;
      transaction.update(foodRef, food.toMap());
    });
  }

  Future<void> updateFood(Food food) {
    return _db.collection('foods').doc(food.id).update(food.toMap());
  }
}
