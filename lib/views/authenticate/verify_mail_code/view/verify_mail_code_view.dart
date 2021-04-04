import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/base/view/base_widget.dart';
import '../viewmodel/verify_mail_code_viewmodel.dart';
import '../../../../core/extention/context_extention.dart';

class VerifyMailCodeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      model: VerifyMailCodeViewModel(),
      onModelReady: (model){
        model.setContext(context);
        model.init();
      },
      builder: (BuildContext context, VerifyMailCodeViewModel viewModel) => Scaffold(
        appBar: AppBar(
          title: Text("Verify Mail Code Page"),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: context.height * 0.8,
            child: Padding(padding: context.paddingMedium,
              child: Column(
                children: [
                  Expanded(flex:1,
                    child: Text("Please check your e-mail address and enter verification code below.",
                            style: Theme.of(context).textTheme.headline6)
                  ),
                  Expanded(flex:2,
                    child:buildMailFormField(context,viewModel, "Verification Code",
                        "Enter verification code here.")
                  ),
                  Expanded(flex: 1,
                    child:Padding(padding: context.paddingMediumVertical,
                        child: buildSendButton(context, viewModel))),
                  Expanded(flex:1,
                  child: buildSendCodeAgain(context)),
                ],
              )
            )
          ),
              ),
            ),
          );
  }

  ElevatedButton buildSendButton(BuildContext context, VerifyMailCodeViewModel viewModel) {
    return ElevatedButton(
      onPressed: () {
        viewModel.navigateResetPasswordPage();
      },
      child: Center(child: Text("SEND")),
    );
  }

  TextButton buildSendCodeAgain(BuildContext context){
      return TextButton(
        onPressed: () {},
        child: Align(alignment: Alignment.center,
          child: Text("Send code again?"),
        )
      );
  }

  TextFormField buildMailFormField(BuildContext context, VerifyMailCodeViewModel viewmodel, 
      String hint, String label) {
    return TextFormField(
      validator: (value) => emptyCheck(value),
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          border: UnderlineInputBorder()),
    );
  }
      
  String emptyCheck(String value) {
    if (value.isEmpty){
      return "E-mail is required!";
    }
    return null;
  }


}



