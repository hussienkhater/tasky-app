import 'package:flutter/material.dart';
import 'package:tasky_app/home_screen.dart';
import 'package:tasky_app/text_form_field_eidget.dart';
import 'package:tasky_app/validator_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  var fullName = TextEditingController();
  var confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style: TextStyle(
                      color: Color(0xff24252C),
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text('Username'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormFieldWidget(
                    controller: fullName,
                    validator: Validator.validateName,
                    hintText: 'Enter Full Name...',
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text('Email'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormFieldWidget(
                    controller: email,
                    validator: Validator.validateEmail,
                    hintText: 'Enter Email...',
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text('Password'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormFieldWidget(
                    controller: password,
                    validator: (value) => Validator.validatePassword(value),
                    hintText: 'Password...',
                    isPassword: true,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text('Confirm Password'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormFieldWidget(
                    controller: confirmPassword,
                    validator: (value) =>
                        Validator.validateConfirmPassword(value, password.text),
                    hintText: 'Password...',
                    isPassword: true,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 85,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 48,
                    minWidth: double.infinity,
                    color: Color(0xff5F33E1),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routeName);
                      }
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: double.infinity,
          color: Color(0xffFFFFFF),
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(
                color: Color(0xff6E6A7C),
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: 'Login',
                  style: TextStyle(
                    color: Color(0xff5F33E1),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
