import 'package:amplify_auth/components/my_button.dart';
import 'package:amplify_auth/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth/screens/login_page.dart';
import 'package:amplify_auth/screens/confirmation_page.dart';

class SignupPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SignupPage({super.key});

  Future<void> _signUpUser(BuildContext context) async {
    final email = emailController.text;
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ConfirmationPage()));
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          // logo
          const Icon(
            Icons.lock,
            size: 100,
          ),
          // Welcome text
          Text(
            "Welcome back you've been missed",
            style: TextStyle(color: Colors.grey[700]),
          ),
          SizedBox(
            height: 25,
          ),
          // username text field
          MyTextField(
            controller: emailController,
            hintText: "Email",
            obscurText: false,
          ),
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
            onTap: () => _signUpUser(context),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have account? "),
              const SizedBox(
                width: 4,
              ),
              Text(
                "Sign in",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
