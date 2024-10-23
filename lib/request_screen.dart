import 'package:flutter/material.dart';
import 'package:secondserving/food_request.dart';
import 'package:secondserving/food_request_service.dart';

class SentRequestsScreen extends StatelessWidget {
  final String userId;
  final FoodRequestService _foodRequestService = FoodRequestService();

  SentRequestsScreen({required this.userId});

  void _cancelRequest(BuildContext context, FoodRequest request) {
    _foodRequestService.cancelFoodRequest(request.id).then((success) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request canceled successfully.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to cancel the request.')),
        );
      }
    });
  }

  void _editRequest(BuildContext context, FoodRequest request) {
    final TextEditingController quantityController = TextEditingController(text: request.quantity.toString());
    final TextEditingController locationController = TextEditingController(text: request.location);
    final TextEditingController contactController = TextEditingController(text: request.contact);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Request'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              TextField(
                controller: contactController,
                decoration: InputDecoration(labelText: 'Contact'),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save the updated values
                double updatedQuantity = double.tryParse(quantityController.text) ?? request.quantity;
                String updatedLocation = locationController.text;
                String updatedContact = contactController.text;

                _foodRequestService.updateFoodRequest(request.id, updatedQuantity, updatedLocation, updatedContact).then((success) {
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Request updated successfully.')),
                    );
                    Navigator.of(context).pop(); // Close the dialog
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update the request.')),
                    );
                  }
                });
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sent Requests'),
      ),
      body: StreamBuilder<List<FoodRequest>>(
        stream: _foodRequestService.getUserFoodRequests(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No sent requests found.'));
          }

          final requests = snapshot.data!;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.foodName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 4),
                      Text('Quantity: ${request.quantity}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 4),
                      Text('Location: ${request.location}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 4),
                      Text('Contact: ${request.contact}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 4),
                      Text('Requested at: ${_formatDate(request.requestedAt)}', style: TextStyle(fontSize: 14)),
                      SizedBox(height: 8),
                      if (request.status != 'approved')
                        ElevatedButton(
                          onPressed: () {
                            _editRequest(context, request);
                          },
                          child: Text('Edit'),
                        ),
                      if (request.status != 'approved')
                        ElevatedButton(
                          onPressed: () {
                            _cancelRequest(context, request);
                          },
                          child: Text('Cancel'),
                        ),
                      if (request.status == 'approved')
                        Text('Status: Approved', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.month}/${date.day}/${date.year}, ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}
