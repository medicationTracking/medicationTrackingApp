import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:medication_app_v0/core/init/cache/shared_preferences_manager.dart';
import 'package:medication_app_v0/core/init/navigation/navigation.service.dart';
import 'package:medication_app_v0/core/init/navigation/navigation_route.dart';
import 'package:medication_app_v0/core/init/notifier/provider_list.dart';
import 'package:medication_app_v0/core/init/notifier/theme_notifier.dart';
import 'package:medication_app_v0/views/Inventory/view/inventory_view.dart';
import 'package:medication_app_v0/views/splash/view/splash_view.dart';
import 'package:provider/provider.dart';
import 'package:medication_app_v0/core/constants/app_constants/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'views/authenticate/login/view/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SharedPreferencesManager.preferencesInit();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
        providers: [...ApplicationProvider.instance.singleItems],
        child: EasyLocalization(
            child: MyApp(),
            supportedLocales: AppConstants.SUPPORTED_LOCALES,
            fallbackLocale: AppConstants.EN_LOCALE,
            path: AppConstants.LANG_PATH)),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context
          .locale, // saveLocale is true by default. Locale is saved to device.
      theme: Provider.of<ThemeNotifier>(context, listen: false).currentTheme,
      title: 'Material App',
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      initialRoute: NavigationConstants.SPLASH_VIEW,
      //home: InventoryView(),
      debugShowCheckedModeBanner: false,
    );
  } //Home degisebilir
}
