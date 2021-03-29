import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/init/navigation/navigation.service.dart';
import 'package:medication_app_v0/core/init/navigation/navigation_route.dart';
import 'views/authenticate/login/view/login_view.dart';
import 'views/authenticate/singup/view/signup_view.dart';

import 'views/home/view/home_view.dart';
import 'views/test/view/test_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      home: LoginView(),
    );
  }
}
