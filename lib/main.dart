import 'package:amplify_auth/screens/signup_page.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth/amplifyconfiguration.dart';
import 'package:amplify_auth/screens/login_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Amplify TODO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AmplifyTODO(),
    ),
  );
}

class AmplifyTODO extends StatefulWidget {
  AmplifyTODO({super.key});

  @override
  _AmplifyTODOState createState() => _AmplifyTODOState();
}

class _AmplifyTODOState extends State<AmplifyTODO> {
  void _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignupPage(),
    );
  }
}
