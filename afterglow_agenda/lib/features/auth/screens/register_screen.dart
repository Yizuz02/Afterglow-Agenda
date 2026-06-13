import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
    const RegisterScreen({super.key});

    @override
    State<RegisterScreen> createState() =>
            _RegisterScreenState();
}

class _RegisterScreenState
        extends State<RegisterScreen> {

    final _emailController =
            TextEditingController();

    final _passwordController =
            TextEditingController();

    final AuthService _auth =
            AuthService();

    bool loading = false;

    Future<void> register() async {

        try {

            setState(() {
                loading = true;
            });

            await _auth.register(
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
                title: const Text("Register"),
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
                                    loading ? null : register,
                            child: const Text(
                                "Register",
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}