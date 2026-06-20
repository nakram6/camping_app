import 'package:flutter/material.dart';

import '../../services/auth/auth_service.dart';

class RegisterScreen
extends StatefulWidget {
const RegisterScreen({
super.key,
});

@override
State<RegisterScreen>
createState() =>
_RegisterScreenState();
}

class _RegisterScreenState
extends State<
RegisterScreen> {
final emailController =
TextEditingController();

final passwordController =
TextEditingController();

bool loading = false;

Future<void> register() async {
try {
setState(() {
loading = true;
});


  await AuthService.register(
    email:
        emailController.text.trim(),
    password:
        passwordController.text.trim(),
  );

  if (mounted) {
    Navigator.pop(context);
  }
} catch (e) {
  ScaffoldMessenger.of(context)
      .showSnackBar(
    SnackBar(
      content: Text(
        e.toString(),
      ),
    ),
  );
}

setState(() {
  loading = false;
});


}

@override
Widget build(
BuildContext context) {
return Scaffold(
appBar: AppBar(
title:
const Text(
"Register",
),
),
body: Padding(
padding:
const EdgeInsets.all(20),
child: Column(
children: [
TextField(
controller:
emailController,
decoration:
const InputDecoration(
labelText: "Email",
),
),
const SizedBox(
height: 12,
),
TextField(
controller:
passwordController,
obscureText: true,
decoration:
const InputDecoration(
labelText:
"Password",
),
),
const SizedBox(
height: 20,
),
SizedBox(
width:
double.infinity,
child: ElevatedButton(
onPressed:
loading
? null
: register,
child: loading
? const CircularProgressIndicator()
: const Text(
"Register",
),
),
),
],
),
),
);
}
}
