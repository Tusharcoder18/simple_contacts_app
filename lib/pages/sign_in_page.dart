import 'package:contacts_app/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/authentication_service.dart';
import '../widgets/custom_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController? controllerEmail = TextEditingController();
  TextEditingController? controllerPassword = TextEditingController();

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
        title: const Text("SIGN IN"),
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
            CustomButton(
              title: "Sign In",
              icon: Icons.login,
              onTap: () {
                debugPrint(controllerEmail?.text);
                debugPrint(controllerPassword?.text);
                context.read<AuthenticationService>().signIn(
                    email: controllerEmail?.text,
                    password: controllerPassword?.text);
              },
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignUp()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blueAccent),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
