import 'package:flutter/material.dart';

import 'features/auth/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Afterglow Agenda',
        ),
        actions: [

          IconButton(
            onPressed: () {
              auth.logout();
            },
            icon: const Icon(
              Icons.logout,
            ),
          )

        ],
      ),

      body: Center(
        child: Text(
          auth.currentUser?.email ??
              'Unknown user',
        ),
      ),
    );
  }
}