import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/bloc/session/session_bloc.dart';
import 'package:kozy_app/ui/home/layouts/home_layout.dart';
import 'package:kozy_app/ui/auth/layouts/auth_layout.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<SessionBloc>(context);
    provider.add(SessionValidate());

    return BlocConsumer(
      bloc: provider,
      builder: (context, state) {
        if (state is SessionAuthorized) {
          return const HomeLayout();
        }
        if (state is SessionUnauthorized || state is SessionFailure) {
          return const AuthLayout();
        }
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [Center(child: Text('Kozy App'))],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
