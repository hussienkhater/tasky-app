import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/app_dialog.dart';
import 'package:tasky_app/feature/auth/view/home_screen.dart';
import 'package:tasky_app/feature/auth/view/register_screen.dart';
import 'package:tasky_app/feature/auth/widgets/elevate_button.dart';
import 'package:tasky_app/feature/auth/widgets/text_form_field_widget.dart';
import 'package:tasky_app/core/utils/validator_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (formKey.currentState!.validate()) {
      AppDialog.showLoadingDialog(context);
      try {
        await login(emailController.text, passwordController.text);
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 122),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Color(0xff24252C),
                  ),
                ),
                SizedBox(height: 53),
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff24252C),
                  ),
                ),
                SizedBox(height: 5),
                TextFormFieldWidget(
                  controller: emailController,
                  hint: "Enter Your Email",
                  borderRadius: BorderRadius.circular(10),
                  onValidate: (text) {
                    return Validator.validateEmail(text);
                  },
                ),
                SizedBox(height: 26),
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff24252C),
                  ),
                ),
                SizedBox(height: 5),
                TextFormFieldWidget(
                  controller: passwordController,
                  isPassword: true,
                  hint: "Password",
                  borderRadius: BorderRadius.circular(10),
                  onValidate: (text) {
                    return Validator.validatePassword(text);
                  },
                ),
                SizedBox(height: 71),
                Center(
                  child: ElevateButtonScreen(
                    text: 'Login',
                    onpressed: _onLogin,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, HomeScreen.routeName);
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

Future<UserCredential> login(String email, String password) async {
  try {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      throw 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      throw 'Wrong password provided for that user.';
    } else {
      throw e.message ?? 'Login failed';
    }
  }
}
