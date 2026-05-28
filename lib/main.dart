import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'features/auth/providers/auth_provider.dart';
import 'features/auth/pages/splash_page.dart';

import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              AuthProvider(),
        ),
      ],
      child:
          const MementalesApp(),
    ),
  );
}

class MementalesApp
    extends StatelessWidget {

  const MementalesApp({
    super.key,
  });

  @override
  Widget build(
      BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner:
          false,

      theme:
          AppTheme.lightTheme,

      home: const SplashPage(),
    );
  }
}