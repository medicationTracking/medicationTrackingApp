import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import '../../verify_mail_code/view/verify_mail_code_view.dart';
import '../../../../core/base/view/base_widget.dart';
import '../viewmodel/forgot_password_viewmodel.dart';
import '../../../../core/extention/context_extention.dart';

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      model: ForgotPasswordViewModel(),
      onModelReady: (model){
        model.setContext(context);
        model.init();
      },
      builder: (BuildContext context, ForgotPasswordViewModel viewModel) => Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(flex:3, child:Container(color: Colors.blue, height: MediaQuery.of(context).size.height)),
            Expanded(flex: 5, child:SingleChildScrollView(
                child: SizedBox(
                  height: context.height * 0.6,
                  child: Padding(padding: context.paddingMedium,
                    child: Column(
                      children: [
                        Expanded( flex:1, child: Text("Please enter your e-mail address below to reset your password.",
                            style: Theme.of(context).textTheme.headline6)),
                        Expanded( flex: 1, child:buildMailFormField(context,viewModel, "E-mail",
                         Icon(Icons.email))),
                        Expanded( flex: 2, child: buildButtons(context, viewModel))
                      ]
                    )
                  )
                ),
            ),),
          ]
        )
      )
    );
  }

  Padding buildButtons(BuildContext context, ForgotPasswordViewModel viewModel){
    return Padding(padding: context.paddingHighVertical,
      child: Row(
        children: [
          Expanded(flex: 10, child: buildSendButton(context, viewModel)),
          Spacer(),
          Expanded(flex: 10, child: buildCancelButton(context, viewModel)),
        ],
      ),
    );
  }

  ElevatedButton buildSendButton(
    BuildContext context, ForgotPasswordViewModel viewModel) {
    return ElevatedButton(
      onPressed: () {viewModel.navigateVerifyMailCodePage();},
      child: Center(child: Text("SEND"),),
      style: Theme.of(context).elevatedButtonTheme.style.copyWith(
          backgroundColor:
              MaterialStateProperty.all<Color>(ColorTheme.RED_BUTTON))
    );
  }

  ElevatedButton buildCancelButton(BuildContext context, ForgotPasswordViewModel viewModel) {
    return ElevatedButton(
      onPressed: () {
        viewModel.navigateLoginPage();
      }, 
    child: Center(child: Text("CANCEL")),
    );
  }

  TextFormField buildMailFormField(BuildContext context, ForgotPasswordViewModel viewmodel, 
     String hint, Icon icon) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      validator: (value) => viewmodel.validateEmail(value),
            decoration: InputDecoration(
              hintText: hint,
              icon: icon,
              border: UnderlineInputBorder()),
    );
  }
}



