import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/bloc/session/session_bloc.dart';

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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onSignInPressed() {
    if (_formKey.currentState!.validate()) {
      String email = emailController.value.text;
      String password = passwordController.value.text;
      final provider = BlocProvider.of<SessionBloc>(context);
      provider.add(SessionSignIn(email: email, password: password));
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter email';
                  if (!EmailValidator.validate(v)) return 'Please enter valid email';

                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text('Password'),
              TextFormField(
                controller: passwordController,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Please enter password' : null,
                obscureText: true,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    child: const Text('Sign In'),
                    onPressed: () => onSignInPressed(),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
