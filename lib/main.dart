import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/bloc/session/session_bloc.dart';
import 'package:kozy_app/ui/home/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SessionBloc()),
        ],
        child: MaterialApp(
          title: 'Kozy',
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          home: const HomePage(),
        ));
  }
}
