import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/repository/auth_repository.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onSignInPressed(AuthRepository authRepository) {
    if (_formKey.currentState!.validate()) {
      String email = emailController.value.text;
      String password = passwordController.value.text;
      final future = authRepository.signIn(email, password);
      future.whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed.')),
        );
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authRepository = RepositoryProvider.of<AuthRepository>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Email'),
              TextFormField(
                controller: emailController,
              ),
              const SizedBox(height: 20),
              const Text('Password'),
              TextFormField(
                controller: passwordController,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    child: const Text('Sign In'),
                    onPressed: () => onSignInPressed(authRepository),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
