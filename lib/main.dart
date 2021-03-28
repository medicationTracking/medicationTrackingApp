import 'package:flutter/material.dart';
import 'views/authenticate/login/view/login_view.dart';
import 'views/authenticate/singup/view/signup_view.dart';

import 'views/test/view/test_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: TestView(),
    );
  }
}
