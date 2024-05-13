import 'package:amplify_auth/components/my_button.dart';
import 'package:amplify_auth/components/my_textfield.dart';
import 'package:amplify_auth/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class SignupPage extends StatelessWidget {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final codeController = TextEditingController();
  SignupPage({super.key});

  Future<void> _signUpUser(BuildContext context) async {
    final email = emailController.text;
    // final username = usernameController.text;
    final password = passwordController.text;
    try {
      final userAttributes = {
        AuthUserAttributeKey.email: email,
      };
      final result = await Amplify.Auth.signUp(
          username: email,
          password: password,
          options: SignUpOptions(userAttributes: userAttributes));
      await _handleSignUpResult(context, result);
    } on AuthException catch (e) {
      safePrint('Error signing up user: ${e.message}');
    }
  }

  Future<void> _handleSignUpResult(
      BuildContext context, SignUpResult result) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Please enter your confirmation code: "),
                content: TextField(
                  controller: codeController,
                  decoration: InputDecoration(hintText: "Confirmation code"),
                ),
                actions: [
                  TextButton(
                      onPressed: () => confirmUser(context,
                          username: emailController.text,
                          confirmationCode: codeController.text),
                      child: Text("Confirm"))
                ],
              );
            });
        break;
      case AuthSignUpStep.done:
        safePrint('Sign up is complete');
        break;
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

  Future<void> confirmUser(
    BuildContext context, {
    required String username,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
      // Check if further confirmations are needed or if
      // the sign up is complete.
      await _handleSignUpResult(context, result);
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Column(
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
            "Welcome!",
            style: TextStyle(color: Colors.grey[700]),
          ),
          // SizedBox(
          //   height: 25,
          // ),
          // // username text field
          // MyTextField(
          //   controller: emailController,
          //   hintText: "Email",
          //   obscurText: false,
          // ),
          SizedBox(
            height: 10,
          ),
          MyTextField(
              controller: emailController,
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
            height: 10,
          ),
          //sign up button
          MyButton(
            text: "SIGN UP",
            onTap: () => _signUpUser(context),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account? "),
              const SizedBox(
                width: 4,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogInPage()));
                },
                child: Text(
                  "Sign in",
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
