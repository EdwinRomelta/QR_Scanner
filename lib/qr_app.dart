import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/ui/screen/login/login_screen.dart';
import 'package:qr_scanner/ui/screen/qr_scanner/qr_scanner_screen.dart';

class QrApp extends StatelessWidget {
  const QrApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: _AuthGate(),
      );
}

class _AuthGate extends StatelessWidget {
  const _AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginScreen();
        }
        return const QrScannerScreen();
      },
    );
  }
}
