import 'package:flutter/material.dart';
import 'package:kozy_app/ui/auth/pages/auth_page.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              AuthPage()
        ],
      ),
    );
  }
}
