import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/base/view/base_widget.dart';
import '../../../../core/constants/image/image_constants.dart';
import '../viewmodel/login_viewmodel.dart';
import '../../../../core/extention/context_extention.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      model: LoginViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onDispose: (model){
        model.dispose();
      },
      builder: (BuildContext context, LoginViewModel viewModel) => Scaffold(
        key: viewModel.scaffoldState,
        body: SingleChildScrollView(
          child: SizedBox(
            height: context.height,
            child: Column(
              children: [
                Expanded(flex: 40, child: buildLogoImage),
                Expanded(flex: 40, child: buildForms(context, viewModel)),
                Expanded(flex: 30, child: buildButtons(context, viewModel))
              ],
            ),
          ),
        ),
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
          Spacer(flex: 3)
        ],
      ),
    );
  }

  Center get buildLogoImage {
    return Center(child: Image.asset(ImageConstants.instance.heartPulse));
  }

  Widget buildTextForgot(BuildContext context,) =>
      Align(
        alignment: Alignment.centerRight,
        child: Text("Forgot Password ?"),
      );
  ElevatedButton buildSignupElevatedButton(
      BuildContext context, LoginViewModel viewModel) {
    return ElevatedButton(
      child: Center(child: Text("SIGN UP")),
      onPressed: () {
        viewModel.navigateSingupPage();
      },
    );
  }

  ElevatedButton buildLoginElevatedButton(
      BuildContext context, LoginViewModel viewModel) {
    return ElevatedButton(
      child: Center(
        child: Text("LOGIN"),
      ),
      onPressed: () {
        print("mail:" +
            viewModel.mailController.text +
            " password:" +
            viewModel.passwordController.text);
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff3BCCBB))),
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
            Expanded(flex: 4, child: buildMailFormField(context, value)),
            Expanded(flex: 4, child: buildPasswordFormField(context, value)),
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
          border: OutlineInputBorder(),
          hintText: "Enter your email",
          labelText: "EMAIL",
          icon: Icon(Icons.email)),
    );
  }

  Widget buildPasswordFormField(
      BuildContext context, LoginViewModel viewmodel) {
    return Observer(builder: (_) {
      return TextFormField(
        controller: viewmodel.passwordController,
        validator: (value) => value.isNotEmpty ? null : "This field required!",
        obscureText: !viewmodel.isPasswordVisible,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your email",
          labelText: "PASSWORD",
          icon: Icon(Icons.lock),
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
}
