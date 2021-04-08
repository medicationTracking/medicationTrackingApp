import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/init/navigation/transitions/fade_route.dart';
import 'package:medication_app_v0/core/init/navigation/transitions/rotation_route.dart';
import 'package:medication_app_v0/core/init/navigation/transitions/scale_rotate_route.dart';
import 'package:medication_app_v0/core/init/navigation/transitions/scale_route.dart';
import 'package:medication_app_v0/core/init/navigation/transitions/size_route.dart';
import 'package:medication_app_v0/core/init/navigation/transitions/slide_route.dart';
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
