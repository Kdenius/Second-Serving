class FoodRequest {
  String id; // ID of the food request
  String userId; // ID of the user requesting the food
  String foodId;
  String foodName; // Name of the requested food
  DateTime requestedAt; // Timestamp of the request
  String location; // Location where food is needed
  double quantity; // Quantity of food requested
  String contact; // Contact number of the requester
  String status; // Status of the request (default is "requested")

  FoodRequest({
    required this.id, // Include this in the constructor
    required this.userId,
    required this.foodId,
    required this.foodName,
    required this.requestedAt,
    required this.location,
    required this.quantity,
    required this.contact,
    this.status = 'requested', // Default status
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'foodId': foodId,
      'foodName': foodName,
      'requestedAt': requestedAt.toIso8601String(),
      'location': location,
      'quantity': quantity,
      'contact': contact,
      'status': status, // Include status in the map
    };
  }

  static FoodRequest fromMap(Map<String, dynamic> map, String id) {
    return FoodRequest(
      id: id, // Set the ID here
      userId: map['userId'],
      foodId: map['foodId'],
      foodName: map['foodName'],
      requestedAt: DateTime.parse(map['requestedAt']),
      location: map['location'],
      quantity: map['quantity'],
      contact: map['contact'],
      status: map['status'] ?? 'requested', // Set status, defaulting to 'requested' if not present
    );
  }
}
