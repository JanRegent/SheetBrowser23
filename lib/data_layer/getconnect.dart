import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';

class GetConnectView extends StatelessWidget {
  final MyApiClient apiClient = MyApiClient();

  GetConnectView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My View'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final response = await apiClient.getData();
            if (!response.status.hasError) {
              final data = response.body;
              // Handle the response data
              print(data);
            } else {
              throw Exception('Failed to load data');
            }
          },
          child: const Text('Fetch Data'),
        ),
      ),
    );
  }
}

class MyApiClient extends GetConnect {
  Future<Response> getData() =>
      get('https://jsonplaceholder.typicode.com/posts');
}
