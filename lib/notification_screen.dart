import 'package:flutter/material.dart';
import 'food_request_service.dart';
import 'food_request.dart';

class NotificationsScreen extends StatelessWidget {
  final String donorId;
  final FoodRequestService _foodRequestService = FoodRequestService();

  NotificationsScreen({required this.donorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: StreamBuilder<List<FoodRequest>>(
        stream: _foodRequestService.getDonorFoodRequests(donorId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No food requests available.'));
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
                      Text('Requested at: ${_formatDate(request.requestedAt)}', style: TextStyle(fontSize: 14)),
                      SizedBox(height: 8),
                      if (request.status == 'requested') // Check if status is 'requested'
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _foodRequestService.approveFoodRequest(request.id).then((success) {
                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Request accepted.')),
                                    );
                                    // Notify user about acceptance
                                    _foodRequestService.notifyUser(request.userId, 'Request Accepted', 'Your request for ${request.foodName} has been accepted.');
                                  }
                                });
                              },
                              child: Text('Accept'),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                _foodRequestService.declineFoodRequest(request.id).then((success) {
                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Request declined.')),
                                    );
                                    // Notify user about decline
                                    _foodRequestService.notifyUser(request.userId, 'Request Declined', 'Your request for ${request.foodName} has been declined.');
                                  }
                                });
                              },
                              child: Text('Decline'),
                            ),
                          ],
                        )
                      else
                        Text(
                          'Status: ${request.status}', // Show the status if not 'requested'
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
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
