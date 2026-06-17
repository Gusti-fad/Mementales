import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  await Supabase.initialize(
    url: 'https://muzgjoadcxaneupeenfh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im11emdqb2FkY3hhbmV1cGVlbmZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODAwMzA2MzMsImV4cCI6MjA5NTYwNjYzM30.ZFnK2bz3fBeFxABUkKSdCKtPRKBxJrDOAayh_0iv2QY',
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