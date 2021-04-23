import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/init/navigation/transitions/fade_route.dart';
import 'package:medication_app_v0/core/init/navigation/transitions/rotation_route.dart';
import 'package:medication_app_v0/core/init/navigation/transitions/scale_rotate_route.dart';
import 'package:medication_app_v0/core/init/navigation/transitions/scale_route.dart';
import 'package:medication_app_v0/core/init/navigation/transitions/size_route.dart';
import 'package:medication_app_v0/core/init/navigation/transitions/slide_route.dart';
import 'package:medication_app_v0/views/authenticate/forgot_password/view/forgot_password_view.dart';
import 'package:medication_app_v0/views/authenticate/reset_password/view/reset_password_view.dart';
import 'package:medication_app_v0/views/authenticate/verify_mail_code/view/verify_mail_code_view.dart';
import 'package:medication_app_v0/views/profile/view/profile_view.dart';
import 'package:medication_app_v0/views/splash/view/splash_view.dart';
import '../../../views/home/view/home_view.dart';
import '../../constants/navigation/navigation_constants.dart';
import '../../../views/authenticate/login/view/login_view.dart';
import '../../../views/authenticate/singup/view/signup_view.dart';

class NavigationRoute {
  static NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;
  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationConstants.SPLASH_VIEW:
        return _navigateToFadeDeafult(SplashView(), settings);
      case NavigationConstants.LOGIN_VIEW:
        return _navigateToSizeDeafult(LoginView(), settings);
      case NavigationConstants.SIGNUP_VIEW:
        return _navigateToScaleRotateDeafult(SignUpView(), settings);
      case NavigationConstants.HOME_VIEW:
        return _navigateToFadeDeafult(HomeView(), settings);
      case NavigationConstants.FORGOT_PASSWORD_VIEW:
        return _navigateToFadeDeafult(ForgotPasswordView(), settings);
      case NavigationConstants.RESET_PASSWORD_VIEW:
        return _navigateToFadeDeafult(ResetPasswordView(), settings);
      case NavigationConstants.VERIFY_MAIL_CODE_VIEW:
        return _navigateToFadeDeafult(VerifyMailCodeView(), settings);
      case NavigationConstants.PROFILE_VIEW:
        return _navigateToFadeDeafult(ProfileView(), settings);
      default:
        return _normalNavigate(Scaffold(
          body: Text("Not Found"),
        ));
    }
  }

  MaterialPageRoute _normalNavigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }

  static PageRoute _navigateToFadeDeafult(Widget page, RouteSettings settings) {
    return FadeRoute(page: page, settings: settings);
  }

  static PageRoute _navigateToRotationDeafult(
      Widget page, RouteSettings settings) {
    return RotationRoute(page: page, settings: settings);
  }

  static PageRoute _navigateToScaleRotateDeafult(
      Widget page, RouteSettings settings) {
    return ScaleRotateRoute(page: page, settings: settings);
  }

  static PageRoute _navigateToScaleDeafult(
      Widget page, RouteSettings settings) {
    return ScaleRoute(page: page, settings: settings);
  }

  static PageRoute _navigateToSizeDeafult(Widget page, RouteSettings settings) {
    return SizeRoute(page: page, settings: settings);
  }

  static PageRoute _navigateToSlideDeafult(
      Widget page, RouteSettings settings) {
    return SlideRightRoute(page: page, settings: settings);
  }
}
