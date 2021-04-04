import 'package:flutter/material.dart';
import '../../../views/authenticate/reset_password/view/reset_password_view.dart';
import '../../../views/authenticate/verify_mail_code/view/verify_mail_code_view.dart';
import '../../../views/authenticate/forgot_password/view/forgot_password_view.dart';
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
      case NavigationConstants.FORGOT_PASSWORD_VIEW:
        return normalNavigate(ForgotPasswordView());
      case NavigationConstants.RESET_PASSWORD_VIEW:
        return normalNavigate(ResetPasswordView());
      case NavigationConstants.VERIFY_MAIL_CODE_VIEW:
        return normalNavigate(VerifyMailCodeView());
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
