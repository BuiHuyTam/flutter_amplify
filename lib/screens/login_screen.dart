import 'package:amplify_auth/screens/signup_screen.dart';
import 'package:amplify_auth/utils/email_validator.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in"),
      ),
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                validator: (value) =>
                    value!.isEmpty ? "Password is invalid" : null,
              ),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                child: Text("LOG IN"),
                onPressed: () => _loginButtonOnPressed(context),
              ),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                child: Text("SIGN UP"),
                onPressed: () => _gotoSignUpScreen(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loginButtonOnPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      //TODO: Login code
    }
  }

  void _gotoSignUpScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );
  }
}
