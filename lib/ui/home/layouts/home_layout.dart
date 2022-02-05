import 'package:flutter/material.dart';
import 'package:kozy_app/ui/home/pages/home_page.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomePage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '1'),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm_sharp), label: '2')
        ],
      ),
    );
  }
}