import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/core/init/navigation/navigation_service.dart';

class CustomBottomAppBar extends StatelessWidget {
  final NavigationService navigation = NavigationService.instance;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //home
          IconButton(
              iconSize: context.height * 0.05,
              icon: Icon(Icons.home_outlined),
              onPressed: () {
                navigation.navigateToPage(path: NavigationConstants.HOME_VIEW);
              }),
          //not determined
          IconButton(
              icon: Icon(Icons.medical_services_outlined),
              onPressed: () {},
              iconSize: context.height * 0.05),
          //covid page
          IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () {
                navigation.navigateToPage(
                    path: NavigationConstants.COVID_TURKEY_VIEW);
              },
              iconSize: context.height * 0.05),
          //inventory page
          IconButton(
              icon: Icon(Icons.bookmark_outline),
              onPressed: () {
                navigation.navigateToPage(
                    path: NavigationConstants.INVENTORY_VIEW);
              },
              iconSize: context.height * 0.05)
        ],
      ),
    );
  }
}
