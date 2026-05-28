import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthService authService =
      AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              final user =
                  await authService
                      .signInGoogle();
                if(user != null){

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                      const SnackBar(
                        content:
                        Text(
                          "Login berhasil"
                        ),
                      ),
                  );
                }
            },
            child: const Text(
              "Masuk dengan Google",
            ),
          ),
        ),
      ),
    );
  }
}