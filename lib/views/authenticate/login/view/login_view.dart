import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:medication_app_v0/core/components/widgets/loading_inducator.dart';
import 'package:medication_app_v0/core/components/widgets/lottie_widget.dart';
import 'package:medication_app_v0/core/constants/app_constants/app_constants.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:medication_app_v0/core/init/services/google_sign_helper.dart';
import 'package:medication_app_v0/core/init/text/locale_text.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import '../../../../core/base/view/base_widget.dart';
import '../../../../core/constants/image/image_constants.dart';
import '../../../../core/init/theme/color_theme.dart';
import '../viewmodel/login_viewmodel.dart';
import '../../../../core/extention/context_extention.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        model: LoginViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onDispose: (model) {
          model.dispose();
        },
        builder: (BuildContext context, LoginViewModel viewModel) =>
            buildScaffold(viewModel, context));
  }

  Scaffold buildScaffold(LoginViewModel viewModel, BuildContext context) {
    return Scaffold(
        key: viewModel.scaffoldState,
        body: Observer(
          builder: (context) => viewModel.isLoading
              ? PulseLoadingIndicatorWidget()
              : buildLoginSingleChildScrollView(context, viewModel),
        ));
  }

  SingleChildScrollView buildLoginSingleChildScrollView(
      BuildContext context, LoginViewModel viewModel) {
    return SingleChildScrollView(
      child: SizedBox(
        height: context.height,
        child: Column(
          children: [
            Expanded(flex: 30, child: buildLogoImage),
            Expanded(flex: 30, child: buildForms(context, viewModel)),
            Spacer(),
            Expanded(flex: 6, child: buildGoogleSignButton(context, viewModel)),
            Spacer(flex: 2),
            Expanded(flex: 30, child: buildButtons(context, viewModel))
          ],
        ),
      ),
    );
  }

  Widget buildGoogleSignButton(BuildContext context, LoginViewModel viewModel) {
    return Padding(
      padding: context.paddingMediumHorizontal,
      child: ElevatedButton(
        child: Row(
          children: [
            Padding(
              padding: context.paddingLow,
              child: Image(
                image: AssetImage(ImageConstants.instance.googleLogo),
              ),
            ),
            SizedBox(
              width: context.normalValue,
            ),
            Text(
              LocaleKeys.authentication_SIGN_WITH_GOOGLE.locale,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        style: Theme.of(context).elevatedButtonTheme.style.copyWith(
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorTheme.BACKGROUND_WHITE)),
        onPressed: () {
          googleSignInOnPressFunc();
          print("Signin with google account");
        },
      ),
    );
  }

  Padding buildButtons(BuildContext context, LoginViewModel viewModel) {
    return Padding(
      padding: context.paddingMediumHorizontal,
      child: Column(
        children: [
          Expanded(
              flex: 3, child: buildLoginElevatedButton(context, viewModel)),
          Spacer(flex: 1),
          Expanded(
              flex: 3, child: buildSignupElevatedButton(context, viewModel)),
          Spacer(),
          buildChangeLanguageButton(context, viewModel),
          Spacer()
        ],
      ),
    );
  }

  TextButton buildChangeLanguageButton(
      BuildContext context, LoginViewModel viewModel) {
    return TextButton(
        onPressed: () {
          viewModel.changeLanguageOnPress(context);
        },
        child: Text(context.locale.countryCode));
  }

  Center get buildLogoImage {
    return Center(child: LottieCustomWidget(path: "heart_and_pulse"));
  }

  Widget buildTextForgot(
    BuildContext context,
  ) =>
      Align(
        alignment: Alignment.centerRight,
        child: LocaleText(text: LocaleKeys.authentication_FORGOT_PASSWORD),
      );
  ElevatedButton buildSignupElevatedButton(
      BuildContext context, LoginViewModel viewModel) {
    return ElevatedButton(
      child: Center(child: LocaleText(text: LocaleKeys.authentication_SIGNUP)),
      onPressed: () {
        viewModel.navigateSingupPage();
      },
    );
  }

  ElevatedButton buildLoginElevatedButton(
      BuildContext context, LoginViewModel viewModel) {
    return ElevatedButton(
      child: Center(child: LocaleText(text: LocaleKeys.authentication_LOGIN)),
      onPressed: () {
        viewModel.navigateHomePage();
        print("mail:" +
            viewModel.mailController.text +
            " password:" +
            viewModel.passwordController.text);
      },
      //TODO EGER BELIRLEDIGIMIZ TEMA DISINDA BIR RENK VERMEK ISTERSEK COPYWITH DEYIP O SPESIFIK OZELLIGI DEGISTIRIYORUZ.
      style: Theme.of(context).elevatedButtonTheme.style.copyWith(
          backgroundColor:
              MaterialStateProperty.all<Color>(ColorTheme.RED_BUTTON)),
    );
  }

  Form buildForms(BuildContext context, LoginViewModel value) {
    return Form(
      key: value.formState,
      autovalidateMode: AutovalidateMode.always,
      child: Padding(
        padding: context.paddingMediumHorizontal,
        child: Column(
          children: [
            Expanded(flex: 5, child: buildMailFormField(context, value)),
            Expanded(flex: 5, child: buildPasswordFormField(context, value)),
            Expanded(flex: 1, child: buildTextForgot(context)),
          ],
        ),
      ),
    );
  }

  TextFormField buildMailFormField(
      BuildContext context, LoginViewModel viewmodel) {
    return TextFormField(
      validator: (value) => viewmodel.validateEmail(value),
      controller: viewmodel.mailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: buildBorder,
          hintText: LocaleKeys.authentication_MAIL_HINT_TEXT.locale,
          labelText: LocaleKeys.authentication_EMAIL.locale,
          prefixIcon: Icon(Icons.email)),
    );
  }

  Widget buildPasswordFormField(
      BuildContext context, LoginViewModel viewmodel) {
    return Observer(builder: (_) {
      return TextFormField(
        controller: viewmodel.passwordController,
        validator: (value) => value.isNotEmpty
            ? null
            : LocaleKeys.authentication_REQUIRED_TEXT.locale,
        obscureText: !viewmodel.isPasswordVisible,
        decoration: InputDecoration(
          border: buildBorder,
          hintText: LocaleKeys.authentication_PASSWORD_HINT_TEXT.locale,
          labelText: LocaleKeys.authentication_PASSWORD.locale,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: viewmodel.isPasswordVisible
                ? Icon(Icons.remove_red_eye_outlined)
                : Icon(Icons.remove_red_eye_sharp),
            onPressed: () {
              viewmodel.seePassword();
            },
          ),
        ),
      );
    });
  }

  OutlineInputBorder get buildBorder => OutlineInputBorder();

  void googleSignInOnPressFunc() async {
    await GoogleSignHelper.instance.firebaseAuth();
  }
  /*
  void googleSignInOnPressFunc() async {
    var data = await GoogleSignHelper.instance.signIn();
    if (data != null) {
      var userData = await GoogleSignHelper.instance.googleAuthentication();
      print("**********************************$userData");
      print("==============idtoken=${userData.idToken}");
      print("==============accestoken=${userData.accessToken}");
    }
  }*/
}
