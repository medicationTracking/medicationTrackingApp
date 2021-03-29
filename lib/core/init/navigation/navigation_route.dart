import 'package:flutter/material.dart';
import '../../../views/home/view/home_view.dart';
import '../../constants/navigation/navigation_constants.dart';
import '../../../views/authenticate/login/view/login_view.dart';
import '../../../views/authenticate/singup/view/signup_view.dart';
import '../../../views/test/view/test_view.dart';

class NavigationRoute {
  static NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;
  NavigationRoute._init();

  Route<dynamic> generateRoute(args) {
    switch (args.name) {
      case NavigationConstants.LOGIN_VIEW:
        return normalNavigate(LoginView());
      case NavigationConstants.SIGNUP_VIEW:
        return normalNavigate(SignUpView());
      case NavigationConstants.TEST_VIEW:
        return normalNavigate(TestView());
      case NavigationConstants.HOME_VIEW:
        return normalNavigate(HomeView());
      default:
        return normalNavigate(Scaffold(
          body: Text("Not Found"),
        ));
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
