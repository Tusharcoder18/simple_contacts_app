import 'package:contacts_app/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController? controllerEmail = TextEditingController();
  TextEditingController? controllerPassword = TextEditingController();
  TextEditingController? controllerSecret = TextEditingController();

  Widget textBox(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 12,
        ),
        TextField(
          controller: controller,
          obscureText: title == "Password" ? true : false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Enter $title',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("SIGN UP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textBox("Email", controllerEmail!),
            const SizedBox(
              height: 12,
            ),
            textBox("Password", controllerPassword!),
            const SizedBox(height: 12),
            textBox("Secret", controllerSecret!),
            const SizedBox(height: 12),
            CustomButton(
              title: "Sign Up",
              icon: Icons.lock,
              onTap: () {
                debugPrint(controllerEmail?.text);
                debugPrint(controllerPassword?.text);
                debugPrint(controllerSecret?.text);
                context.read<AuthenticationService>().signUp(
                    email: controllerEmail?.text,
                    password: controllerPassword?.text);
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              height: 12,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text(
                  "By clicking the 'Sign Up' button, you are creating an \naccount and you agree to the Terms of Use"),
            ]),
          ],
        ),
      ),
    );
  }
}
