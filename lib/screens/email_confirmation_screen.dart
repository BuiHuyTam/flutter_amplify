import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_auth/screens/main_screen.dart';
import 'package:flutter/material.dart';

class EmailConfirmationScreen extends StatelessWidget {
  final String email;

  EmailConfirmationScreen({
    super.key,
    required this.email,
  });

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _confirmationCodeController =
      TextEditingController();

  final _formKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Confirm your email"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              Text(
                "An email confirmation code is sent to $email. Please type the code to confirm your email.",
                style: Theme.of(context).textTheme.headline6,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _confirmationCodeController,
                decoration: InputDecoration(labelText: "Confirmation Code"),
                validator: (value) => value!.length != 6
                    ? "The confirmation code is invalid"
                    : null,
              ),
              OutlinedButton(
                onPressed: () => _submitCode(context),
                child: Text("CONFIRM"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitCode(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final confirmationCode = _confirmationCodeController.text;
      try {
        final SignUpResult response = await Amplify.Auth.confirmSignUp(
          username: email,
          confirmationCode: confirmationCode,
        );
        if (response.isSignUpComplete) {
          _gotoMainScreen(context);
        }
      } on Exception catch (e) {
        print(e.toString());
      }
    }
  }

  void _gotoMainScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen()));
  }
}
