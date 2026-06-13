import 'package:flutter/material.dart';

import '../../auth/services/auth_service.dart';


class ProfileScreen
        extends StatelessWidget {

    const ProfileScreen({
        super.key,
    });

    @override
    Widget build(BuildContext context) {

        final auth = AuthService();

        return Scaffold(
            appBar: AppBar(
                title: const Text(
                    'Profile',
                ),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment:
                            MainAxisAlignment.center,
                    children: [

                        Text(
                            auth.currentUser?.email ??
                                    '',
                        ),

                        const SizedBox(
                            height: 16,
                        ),

                        ElevatedButton(
                            onPressed: () {
                                auth.logout();
                            },
                            child: const Text(
                                'Logout',
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}