import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/core/init/navigation/navigation_service.dart';
import 'package:medication_app_v0/core/init/services/google_sign_helper.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';

class CustomDrawer extends StatelessWidget {
  final NavigationService navigation = NavigationService.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(
          color: ColorTheme.PRIMARY_BLUE,
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'MEDICATION\nTRACKING',
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: ColorTheme.BACKGROUND_WHITE),
          ),
        ),
      ),
      Card(
        elevation: 4,
        child: ListTile(
            title: Text('HOME'),
            trailing: Icon(Icons.home_rounded),
            onTap: () {
              navigation.navigateToPageClear(
                  path: NavigationConstants.HOME_VIEW);
              //Navigator.pop(context);
            }),
      ),
      Card(
        elevation: 4,
        child: ListTile(
            title: Text('PROFILE'),
            trailing: Icon(Icons.person_rounded),
            onTap: () {
              navigation.navigateToPageClear(
                  path: NavigationConstants.PROFILE_VIEW);
              //Navigator.pop(context);
            }),
      ),
      Card(
          elevation: 1,
          child: ListTile(
              title: Text('ALLERGENS'),
              trailing: Icon(Icons.medical_services_rounded),
              onTap: () {
                navigation.navigateToPageClear(
                    path: NavigationConstants.ALLERGENS_VIEW);
                //Navigator.pop(context);
              })),
      Card(
          child: ListTile(
              title: Text('Logout'),
              trailing: Icon(Icons.login_rounded),
              onTap: () {
                logoutButtonOnPress();
                //Navigator.pop(context);
              }))
    ]));
  }

  void logoutButtonOnPress() async {
    await GoogleSignHelper.instance.signOut();
    navigation.navigateToPageClear(path: NavigationConstants.SPLASH_VIEW);
  }
}
