import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/blocs/authentication/authentication_bloc.dart';
import 'package:kozy_app/pages/pages/sign_in_page.dart';
import 'package:kozy_app/repositories/authentication_repository.dart';

void main() {
  runApp(
    RepositoryProvider<AuthenticationRepository>(
      create: (_) => MainAuthenticationRepository(),
      child: BlocProvider<AuthenticationBloc>(
        create: (context) {
          final repository = RepositoryProvider.of<AuthenticationRepository>(context);
          return AuthenticationBloc(repository)..add(AppLoaded());
        },
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kozy',
      theme: ThemeData(primarySwatch: Colors.primaries.first),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            // show home page
            return Scaffold(
              body: SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Home Page'),
                      TextButton(
                          child: const Text('Sign out'),
                          onPressed: () {
                            final authBloc = BlocProvider.of<AuthenticationBloc>(context);
                            authBloc.add(UserSignedOut());
                          }),
                    ],
                  ),
                ),
              ),
            );
          }
          // otherwise show login page
          return const SignInPage();
        },
      ),
    );
  }
}
