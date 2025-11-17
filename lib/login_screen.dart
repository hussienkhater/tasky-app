import 'package:flutter/material.dart';
import 'package:tasky_app/home_screen.dart';
import 'package:tasky_app/register_screen.dart';
import 'package:tasky_app/text_form_field_eidget.dart';
import 'package:tasky_app/validator_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

var email = TextEditingController();
var password = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xff24252C),
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 50,
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
                  obscureText: true,
                  isPassword: true,
                ),
                SizedBox(
                  height: 85,
                ),
                MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 48,
                  minWidth: double.infinity,
                  color: Color(0xff5F33E1),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RegisterScreen.routeName);
        },
        child: Text.rich(TextSpan(
            text: 'Don’t have an account? ',
            style: TextStyle(
              color: Color(0xff6E6A7C),
              fontSize: 12,
            ),
            children: [
              TextSpan(
                text: 'Register',
                style: TextStyle(
                  color: Color(0xff5F33E1),
                  fontSize: 12,
                ),
              ),
            ])),
      ),
    );
  }
}
