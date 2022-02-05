import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/bloc/session/session_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<SessionBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Authorized'),
                ElevatedButton(
                  child: const Text('Sign out'),
                  onPressed: () => provider.add(SessionSignOut()),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
