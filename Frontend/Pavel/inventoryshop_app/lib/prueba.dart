import 'package:cache_manager/core/read_cache_service.dart';
import 'package:flutter/material.dart';

class UserDataWidget extends StatelessWidget {
    static String routeName = '/user_data';


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: ReadCache.getJson(key: 'user'), // Dynamic return type
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading state
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}"); // Error handling
        } else if (snapshot.data == null) {
          return Text("No data found for the key 'user'"); // Handling null values
        } else {
          try {
            final userData = snapshot.data as Map<String, dynamic>; // Explicit cast
            return Text("User ID: ${userData['data']}"); // Access specific fields
          } catch (e) {
            return Text("Error casting data: ${e.toString()}"); // Handle casting errors
          }
        }
      },
    );
  }
}
