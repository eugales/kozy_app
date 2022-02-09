import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/blocs/blocs.dart';
import 'package:kozy_app/pages/widgets/custom_text_field.dart';
import 'package:kozy_app/repositories/authentication_repository.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            final authBloc = BlocProvider.of<AuthenticationBloc>(context);
            if (state is AuthenticationNotAuthenticatied) {
              return _AuthForm();
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

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<AuthenticationRepository>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(authBloc, repository),
        child: const _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  const _SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
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
    final _signInBloc = BlocProvider.of<SignInBloc>(context);

    void onSignInPressed() {
      if (_formKey.currentState!.validate()) {
        String email = emailController.value.text;
        String password = passwordController.value.text;
        final event = SignInWithEmailButtonPressed(email: email, password: password);
        _signInBloc.add(event);
      }
    }

    void toSignUpPagePressed() {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
    }

    void _showError(String error) {
      Scaffold.of(context).showBottomSheet(
        (context) => SnackBar(
          content: Text(error),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }

    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          _showError(state.message);
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 280,
                        width: double.infinity,
                        child: const Text(
                          'Kozy',
                          style: TextStyle(fontSize: 50),
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Log in to your account',
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
                            if (v == null || v.isEmpty) {
                              return 'Please enter email';
                            }
                            if (!EmailValidator.validate(v)) {
                              return 'Please enter valid email';
                            }
                            return null;
                          }),
                      CustomTextField(
                          labelText: 'Password',
                          hintText: 'Password',
                          iconData: Icons.vpn_key,
                          controller: passwordController,
                          validator: (v) => (v == null || v.isEmpty) ? 'Please enter password' : null,
                          obscureText: true),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: onSignInPressed,
                        height: 45,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors.black,
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          TextButton(
                            onPressed: toSignUpPagePressed,
                            child: const Text(
                              'Register',
                              style: TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
