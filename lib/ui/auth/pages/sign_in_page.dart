import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/bloc/session/session_bloc.dart';
import 'package:kozy_app/ui/auth/pages/sign_up_page.dart';
import 'package:kozy_app/ui/auth/widgets/custom_text_field.dart';

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
      final event = SessionSignIn(email: email, password: password);
      provider.add(event);
    }
  }

  void toSignUpPagePressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpPage()));
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
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
                        validator: (v) => (v == null || v.isEmpty)
                            ? 'Please enter password'
                            : null,
                        obscureText: true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
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
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
