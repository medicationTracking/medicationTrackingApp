import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/components/widgets/custom_bottom_appbar.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import 'package:medication_app_v0/views/authenticate/forgot_password/viewmodel/forgot_password_viewmodel.dart';
import '../../../../core/base/view/base_widget.dart';
import '../viewmodel/reset_password_viewmodel.dart';
import 'package:medication_app_v0/core/components/widgets/drawer.dart';
import '../../../../core/extention/context_extention.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ResetPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      model: ResetPasswordViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      builder: (context, viewModel) => Scaffold(
        appBar: AppBar(
          title: Text("Reset Password"),
          backgroundColor: ColorTheme.PRIMARY_BLUE,
        ),
        drawer: CustomDrawer(),
        bottomNavigationBar: CustomBottomAppBar(),
        body: SingleChildScrollView(
            child: SizedBox(
                height: context.height * 0.8,
                child: Padding(
                    padding: context.paddingMedium,
                    child: Column(
                      children: [
                        Expanded(flex: 1, child: buildText(context)),
                        Expanded(
                            flex: 4, child: buildForms(context, viewModel)),
                        Expanded(
                            flex: 2, child: buildButton(context, viewModel)),
                        Expanded(
                          flex: 2,
                          child: buildPasswordRequiresText(context),
                        )
                      ],
                    )))),
      ),
    );
  }

  Widget buildText(BuildContext context) {
    return Padding(
        padding: context.paddingLowHorizontal,
        child: Text("Please enter new password below",
            style: Theme.of(context).textTheme.headline6));
  }

  SingleChildScrollView buildPasswordRequiresText(BuildContext context) {
    return SingleChildScrollView(
      child: Text(
          "Minimum 1 Uppercase\n,Minimum 1 Lowercase\n,Minimum 1 Numeric Number\nMinimum 8 Characters Long.",
          style: Theme.of(context).textTheme.bodyText2),
    );
  }

  Widget buildForms(BuildContext context, ResetPasswordViewModel value) {
    return Form(
        key: value.formResetPasswordState,
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
            padding: context.paddingLowHorizontal,
            child: Column(
              children: [
                Expanded(child: buildPasswordFormField(context, value)),
                Expanded(
                  child: buildPasswordAgainFormField(context, value),
                ),
              ],
            )));
  }

  Widget buildPasswordFormField(
      BuildContext context, ResetPasswordViewModel viewmodel) {
    return Observer(builder: (_) {
      return TextFormField(
        controller: viewmodel.resetPasswordController,
        validator: (value) => viewmodel.validatePassword(value),
        obscureText: !viewmodel.isPasswordVisible,
        decoration: InputDecoration(
          hintText: "New Password",
          border: UnderlineInputBorder(),
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

  Widget buildPasswordAgainFormField(
      BuildContext context, ResetPasswordViewModel viewmodel) {
    return Observer(builder: (_) {
      return TextFormField(
        controller: viewmodel.resetPasswordAgainController,
        validator: (value) => viewmodel.validatePassword(value),
        obscureText: !viewmodel.isPasswordVisible,
        decoration: InputDecoration(
          hintText: "New Password Again",
          border: UnderlineInputBorder(),
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

  Padding buildButton(BuildContext context, ResetPasswordViewModel viewModel) {
    return Padding(
      padding: context.paddingMedium,
      child: buildSaveButton(viewModel),
    );
  }

  ElevatedButton buildSaveButton(ResetPasswordViewModel viewModel) {
    return ElevatedButton(
      onPressed: () {
        viewModel.changePassword();
        //viewModel.navigateLoginPage();
      },
      child: Center(child: Text("SAVE")),
    );
  }
}
