import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/repository/auth_repository.dart';
import 'package:kozy_app/repository/services/auth_service.dart';
import 'package:kozy_app/ui/auth/pages/sign_in_page.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(service: AuthService()),
      child: SignInPage(),
    );
  }
}
