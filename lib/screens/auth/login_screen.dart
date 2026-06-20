import 'package:flutter/material.dart';

import '../../services/auth/auth_service.dart';
import 'register_screen.dart';

class LoginScreen
extends StatefulWidget {
const LoginScreen({
super.key,
});

@override
State<LoginScreen> createState() =>
_LoginScreenState();
}

class _LoginScreenState
extends State<LoginScreen> {
final emailController =
TextEditingController();

final passwordController =
TextEditingController();

bool loading = false;

Future<void> login() async {
try {
setState(() {
loading = true;
});


  await AuthService.login(
    email:
        emailController.text.trim(),
    password:
        passwordController.text.trim(),
  );
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
const Text("Login"),
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
: login,
child: loading
? const CircularProgressIndicator()
: const Text(
"Login",
),
),
),
TextButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
const RegisterScreen(),
),
);
},
child: const Text(
"Create Account",
),
),
],
),
),
);
}
}
