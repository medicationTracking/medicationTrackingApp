import 'package:flutter/material.dart';
import '../../../../core/base/view/base_widget.dart';
import '../viewmodel/reset_password_viewmodel.dart';
import '../../../../core/extention/context_extention.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ResetPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      model: ResetPasswordViewModel(),
      onModelReady: (model){
        model.setContext(context);
        model.init();
      },
      builder: (BuildContext context, ResetPasswordViewModel viewModel) => Scaffold(
        appBar: AppBar(
          title: Text("Reset Password Page"),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: context.height * 0.8,
            child: Padding(padding: context.paddingMedium,
              child: Column(
                children: [
                  Expanded(flex: 1, child: buildText(context)),
                  Expanded(flex: 4, child: buildForms(context, viewModel)),
                  Expanded(flex: 2, child: buildButton(context, viewModel)), 
                  Expanded(flex: 2, child: buildPasswordRequiresText(context),)                     ],
              )
            )
          )
        ),
      ),
    );
  }

  Widget buildText(BuildContext context){
    return Padding(
      padding: context.paddingLowHorizontal,
        child: Text("Please enter new password below",
              style: Theme.of(context).textTheme.headline6, ))
    ;
  }
  SingleChildScrollView buildPasswordRequiresText(BuildContext context){
    return SingleChildScrollView(
        child: Text("Minimum 1 Uppercase\n,Minimum 1 Lowercase\n,Minimum 1 Numeric Number\nMinimum 8 Characters Long.",
                      style: Theme.of(context).textTheme.bodyText2),
    );
  }

  Widget buildForms(BuildContext context, ResetPasswordViewModel value) {
    return Form(
      key: value.formState,
      autovalidateMode: AutovalidateMode.always,
      child: Padding(
        padding: context.paddingLowHorizontal,
        child:Column(children: [
          Expanded(
            child:buildPasswordFormField(context,value)
          ),
          Expanded(
            child: buildPasswordAgainFormField(context,value),
          ),
        ],)
      )
    );        
  }

  Widget buildPasswordFormField(BuildContext context, ResetPasswordViewModel viewModel) {
    return Observer(builder: (_){
      return TextFormField(
        validator: (value) => viewModel.validatePassword(value),
        obscureText: !viewModel.isPasswordVisible,
        decoration: InputDecoration(
          hintText: "New Password",
          border: UnderlineInputBorder(), 
          icon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: viewModel.isPasswordVisible
              ? Icon(Icons.remove_red_eye_outlined)
              : Icon(Icons.remove_red_eye_sharp),
            onPressed: () {
              viewModel.seePassword();
            },
          ),
        ),
      );
    });
  }

  Widget buildPasswordAgainFormField(BuildContext context, ResetPasswordViewModel viewModel) {
    return Observer(builder: (_){
      return TextFormField(
        validator: (value) => viewModel.validatePassword(value),
        obscureText: !viewModel.isPasswordVisible,
        decoration: InputDecoration(
          hintText: "New Password Again",
          border: UnderlineInputBorder(),
          icon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: viewModel.isPasswordVisible
              ? Icon(Icons.remove_red_eye_outlined)
              : Icon(Icons.remove_red_eye_sharp),
            onPressed: () {
              viewModel.seePassword();
            },
          ),
        ),
      );
    });
  }

 Padding buildButton(BuildContext context, ResetPasswordViewModel viewModel) {
    return Padding(
      padding: context.paddingMedium,
      child: buildSaveButton(context, viewModel),
    );
 }
  
  ElevatedButton buildSaveButton(BuildContext context, ResetPasswordViewModel viewModel) {
    return ElevatedButton(
        onPressed: () {
          viewModel.navigateLoginPage();
        },
        child: Center(child: Text("SAVE")),
      );
  }
  
}