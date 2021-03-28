import 'package:flutter/material.dart';
import 'package:medication_app_v0/views/authenticate/login/view/login_view.dart';
import 'package:medication_app_v0/views/authenticate/singup/view/signup_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: LoginView(),
    );
  }
}
