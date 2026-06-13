import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
    const LoginScreen({super.key});

    @override
    State<LoginScreen> createState() =>
            _LoginScreenState();
}

class _LoginScreenState
        extends State<LoginScreen> {

    final _emailController =
            TextEditingController();

    final _passwordController =
            TextEditingController();

    final AuthService _auth =
            AuthService();

    bool loading = false;

    Future<void> login() async {

        try {

            setState(() {
                loading = true;
            });

            await _auth.login(
                email: _emailController.text.trim(),
                password:
                        _passwordController.text.trim(),
            );

        } catch (e) {

            ScaffoldMessenger.of(context)
                    .showSnackBar(
                SnackBar(
                    content: Text(e.toString()),
                ),
            );

        } finally {

            setState(() {
                loading = false;
            });

        }
    }

    @override
    Widget build(BuildContext context) {

        return Scaffold(
            appBar: AppBar(
                title: const Text("Login"),
            ),
            body: Padding(
                padding:
                        const EdgeInsets.all(16),
                child: Column(
                    children: [

                        TextField(
                            controller:
                                    _emailController,
                            decoration:
                                    const InputDecoration(
                                labelText: "Email",
                            ),
                        ),

                        TextField(
                            controller:
                                    _passwordController,
                            obscureText: true,
                            decoration:
                                    const InputDecoration(
                                labelText: "Password",
                            ),
                        ),

                        const SizedBox(height: 16),

                        ElevatedButton(
                            onPressed:
                                    loading ? null : login,
                            child:
                                    const Text("Login"),
                        ),

                        TextButton(
                            onPressed: () {

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                                const RegisterScreen(),
                                    ),
                                );

                            },
                            child: const Text(
                                "Create account",
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}