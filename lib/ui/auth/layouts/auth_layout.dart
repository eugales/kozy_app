import 'package:flutter/material.dart';
import 'package:kozy_app/ui/auth/pages/sign_in_page.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [SignInPage()],
        ),
      ),
    );
  }
}
