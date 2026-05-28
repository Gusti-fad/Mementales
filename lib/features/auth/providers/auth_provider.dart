import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = true;

  User? get user => _user;

  bool get isLoading => _isLoading;

  AuthProvider() {
    init();
  }

  void init() {
    FirebaseAuth.instance.authStateChanges().listen(
      (user) {
        _user = user;
        _isLoading = false;

        notifyListeners();
      },
    );
  }
}