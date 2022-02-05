import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/bloc/session/session_bloc.dart';
import 'package:kozy_app/ui/auth/pages/sign_in_page.dart';
import 'package:kozy_app/ui/home/pages/home_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<SessionBloc>(context);
    provider.add(SessionValidate());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<SessionBloc, SessionState>(builder: (context, state) {
              if (state is SessionAuthorized) {
                return const HomeLayout();
              }
              if (state is SessionUnauthorized || state is SessionFailure) {
                return const SignInPage();
              }
              return const Center(child: Text('Kozy App'));
            })
          ],
        ),
      ),
    );
  }
}
