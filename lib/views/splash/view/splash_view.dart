import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/components/widgets/loading_inducator.dart';
import 'package:medication_app_v0/core/components/widgets/lottie_widget.dart';
import 'package:medication_app_v0/core/constants/app_constants/app_constants.dart';
import 'package:medication_app_v0/core/constants/image/image_constants.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/init/text/locale_text.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import 'package:medication_app_v0/views/splash/viewmodel/splash_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      model: SplashViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      builder: (BuildContext context, SplashViewModel viewModel) =>
          _buildScaffold(viewModel, context),
    );
  }

  Scaffold _buildScaffold(SplashViewModel viewModel, BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _floatingActionButtonChangeLanguage(viewModel, context),
          context.emptySizedHeightBoxNormal,
          _floatingActionButtonLogin(viewModel),
        ],
      ),
      body: Container(child: buildLottie, color: ColorTheme.GREY_LIGHT),
    );
  }

  FloatingActionButton _floatingActionButtonLogin(SplashViewModel viewModel) {
    return FloatingActionButton.extended(
      onPressed: () {
        viewModel.navigateLogin();
      },
      label: Row(
        children: [
          LocaleText(text: LocaleKeys.authentication_LOGIN),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
      backgroundColor: ColorTheme.BACKGROUND_WHITE,
    );
  }

  FloatingActionButton _floatingActionButtonChangeLanguage(
      SplashViewModel viewModel, BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        viewModel.changeLanguage(context);
      },
      child: context.locale == AppConstants.TR_LOCALE
          ? Image.asset(ImageConstants.instance.trFlag)
          : Image.asset(ImageConstants.instance.ukFlag),
      mini: true,
    );
  }

  Center get buildLottie {
    return Center(child: LottieCustomWidget(path: "medical_shield"));
  }
}
