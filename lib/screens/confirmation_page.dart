import 'package:amplify_auth/components/my_button.dart';
import 'package:amplify_auth/components/my_textfield.dart';
import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  ConfirmationPage({super.key});
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Confirmation"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Please enter confirmation code below",
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(
              height: 20,
            ),
            MyTextField(
                controller: codeController,
                hintText: "Confirmation code",
                obscurText: false),
            SizedBox(
              height: 20,
            ),
            MyButton(onTap: () {})
          ],
        ),
      ),
    );
  }
}
