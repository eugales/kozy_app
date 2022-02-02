import 'package:flutter/material.dart';
import 'package:kozy_app/ui/home/pages/home_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeLayout(),
    );
  }
}