import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/bloc/session/session_bloc.dart';
import 'package:kozy_app/ui/auth/pages/sign_in_page.dart';
import 'package:kozy_app/ui/home/layouts/home_layout.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<SessionBloc>(context);

    return BlocConsumer<SessionBloc, SessionState>(
      builder: (context, state) {
        if (state is SessionInitial) {
          provider.add(SessionValidate());
        } else if (state is SessionInprogress) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is SessionAuthorized || state is SessionRegistered) {
          return const HomeLayout();
        } else if (state is SessionUnauthorized || state is SessionFailure) {
          return const SignInPage();
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
