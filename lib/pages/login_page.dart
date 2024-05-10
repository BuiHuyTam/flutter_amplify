import 'package:amplify_auth/components/my_button.dart';
import 'package:amplify_auth/components/my_textfield.dart';
import 'package:amplify_auth/pages/home_page.dart';
import 'package:amplify_auth/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class LogInPage extends StatelessWidget {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final codeController = TextEditingController();
  LogInPage({super.key});

  Future<void> _signInUser(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      if (result.isSignedIn) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        print("Sign in successfully");
      } else {
        print("Please check your email or password again");
      }
    } on AuthException catch (e) {
      safePrint('Error signing in user: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          // logo
          const Icon(
            Icons.lock,
            size: 100,
            color: Colors.grey,
          ),
          // Welcome text
          Text(
            "Welcome back you've been missed",
            style: TextStyle(color: Colors.grey[700]),
          ),
          SizedBox(
            height: 25,
          ),
          MyTextField(
              controller: usernameController,
              hintText: "Username",
              obscurText: false),
          SizedBox(
            height: 10,
          ),
          // password text field
          MyTextField(
            controller: passwordController,
            hintText: "Password",
            obscurText: true,
          ),
          SizedBox(
            height: 25,
          ),
          //sign up button
          MyButton(
            text: "SIGN IN",
            onTap: () => _signInUser(context),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account? "),
              const SizedBox(
                width: 4,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: Text(
                  "Sign up",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
