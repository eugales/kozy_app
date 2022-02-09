import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/blocs/blocs.dart';
import 'package:kozy_app/pages/widgets/custom_text_field.dart';
import 'package:kozy_app/repositories/authentication_repository.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            final authBloc = BlocProvider.of<AuthenticationBloc>(context);
            if (state is AuthenticationNotAuthenticatied) {
              return _RegForm();
            }

            if (state is AuthenticationFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(state.message),
                    TextButton(
                      child: const Text('Retry'),
                      onPressed: () {
                        authBloc.add(AppLoaded());
                      },
                    )
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RegForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<AuthenticationRepository>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(authBloc, repository),
        child: const _SignUpForm(),
      ),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _signUpBloc = BlocProvider.of<SignUpBloc>(context);

    void onSignUpPressed() {
      if (_formKey.currentState!.validate()) {
        String email = emailController.value.text;
        String password = passwordController.value.text;
        final event = SignUpWithEmailButtonPressed(email: email, password: password);

        _signUpBloc.add(event);
      }
    }

    void _showError(String error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pop(context);
        }
        if (state is SignUpFailure) {
          _showError(state.message);
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Register new account',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        labelText: 'Email',
                        hintText: 'Username or e-mail',
                        iconData: Icons.person,
                        controller: emailController,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Please enter email';
                          if (!EmailValidator.validate(v)) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                          labelText: 'Password',
                          hintText: 'Password',
                          iconData: Icons.vpn_key,
                          controller: passwordController,
                          validator: (v) => (v == null || v.isEmpty) ? 'Please enter password' : null,
                          obscureText: true),
                      const SizedBox(
                        height: 45,
                      ),
                      MaterialButton(
                        onPressed: onSignUpPressed,
                        height: 45,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors.black,
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
