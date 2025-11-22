import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/app_dialog.dart';
import 'package:tasky_app/feature/auth/view/home_screen.dart';
import 'package:tasky_app/feature/auth/widgets/elevate_button.dart';
import 'package:tasky_app/feature/auth/widgets/text_form_field_widget.dart';
import 'package:tasky_app/core/utils/validator_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  var fullName = TextEditingController();
  var confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void dispose() {
    fullName.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _onRegister() async {
    if (_formKey.currentState!.validate()) {
      AppDialog.showLoadingDialog(context);
      try {
        await register(email.text, password.text);
        AppDialog.hideDialog(context);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } catch (e) {
        AppDialog.hideDialog(context);
        AppDialog.showErrorDialog(context, e.toString());
      }
    }
  }

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
                  SizedBox(
                    height: 80,
                  ),
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
                    borderRadius: BorderRadius.circular(10),
                    controller: fullName,
                    onValidate: Validator.validateName,
                    hint: 'Enter Full Name...',
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
                    hint: "Enter Your Email",
                    borderRadius: BorderRadius.circular(10),
                    onValidate: Validator.validateEmail,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text('Password'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormFieldWidget(
                    borderRadius: BorderRadius.circular(10),
                    controller: password,
                    onValidate: Validator.validatePassword,
                    hint: 'Password...',
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text('Confirm Password'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormFieldWidget(
                    borderRadius: BorderRadius.circular(10),
                    controller: confirmPassword,
                    onValidate: (value) =>
                        Validator.validateConfirmPassword(value, password.text),
                    hint: 'Password...',
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 85,
                  ),
                  Center(
                  child: ElevateButtonScreen(
                    text: 'Register',
                    onpressed: _onRegister,
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

Future<UserCredential> register(String email, String password) async {
  try {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return credential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      throw 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      throw 'The account already exists for that email.';
    } else {
      throw e.message ?? 'Registration failed';
    }
  }
}
