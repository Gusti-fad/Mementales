import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../../navigation/pages/navigation_page.dart';
import 'login_page.dart';

class SplashPage
    extends StatelessWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(
      BuildContext context) {
    final authProvider =
        context.watch<AuthProvider>();

    if (authProvider.isLoading) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    if (authProvider.user != null) {
      return const NavigationPage();  
    }

    return LoginPage();
  }
}