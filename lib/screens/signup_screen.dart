import 'package:amplify_auth/screens/email_confirmation_screen.dart';
import 'package:amplify_auth/utils/email_validator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email"),
                controller: _emailController,
                validator: (value) =>
                    !validateEmail(value!) ? "Email is Invalid" : null,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                controller: _passwordController,
                validator: (value) => value!.isEmpty
                    ? "Password is invalid"
                    : value.length < 9
                        ? "Password must contain at least 8 characters"
                        : null,
              ),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                child: Text("CREATE ACCOUNT"),
                onPressed: () => _createAccountOnPressed(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createAccountOnPressed(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    try {
      // TODO: Implment sign-up process
      final signUpResult = await Amplify.Auth.signUp(
          username: email,
          password: password,
          options: SignUpOptions(
              userAttributes: {AuthUserAttributeKey.email: email}));
      if (signUpResult.isSignUpComplete) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EmailConfirmationScreen(email: email)));
      }
    } on AuthException catch (e) {
      safePrint("Error occured signing up user ${e}");
    }
  }
}
