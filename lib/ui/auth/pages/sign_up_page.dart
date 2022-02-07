import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/bloc/session/session_bloc.dart';
import 'package:kozy_app/ui/auth/widgets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  String role = '';

  @override
  void initState() {
    emailController.text = 'buyer41@kozy.kz';
    passwordController.text = 'Test1234';
    firstNameController.text = 'Test First Name';
    lastNameController.text = 'Test Last Name';
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  void onSignUpPressed() {
    if (_formKey.currentState!.validate()) {
      String email = emailController.value.text;
      String password = passwordController.value.text;
      String firstName = firstNameController.value.text;
      String lastName = lastNameController.value.text;
      String roleName = role;
      final provider = BlocProvider.of<SessionBloc>(context);
      final event = SessionSignUp(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          roleName: roleName);

      provider.add(event);
    }
  }

  void onDropdownPressed(String? roleName) {
    setState(() {
      role = roleName!.toLowerCase();
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SessionBloc, SessionState>(
        builder: (context, state) {
          if (state is SessionInprogress) {
            return const Center(child: CircularProgressIndicator());
          }

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
                          if (v == null || v.isEmpty)
                            return 'Please enter email';
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
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Please enter password'
                              : null,
                          obscureText: true),
                      CustomTextField(
                          labelText: 'First Name',
                          hintText: 'First Name',
                          iconData: Icons.vpn_key,
                          controller: firstNameController,
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Please enter first name'
                              : null),
                      CustomTextField(
                          labelText: 'Last Name',
                          hintText: 'Last Name',
                          iconData: Icons.vpn_key,
                          controller: lastNameController,
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Please enter last name'
                              : null),
                      SizedBox(
                        height: 80,
                        child: DropdownButtonFormField<String>(
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Choose a role' : null,
                          decoration: InputDecoration(
                            labelText: 'Role',
                            hintText: 'Select role',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade200, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            floatingLabelStyle: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red.shade200, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red.shade200, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          focusColor: Colors.black,
                          isExpanded: true,
                          items:
                              <String>['Buyer', 'Seller'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: onDropdownPressed,
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      MaterialButton(
                        onPressed: onSignUpPressed,
                        height: 45,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
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
        listener: (context, state) {
          if (state is SessionRegistered) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
