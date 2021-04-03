import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
      builder: (context, viewmodel) => Scaffold(
        appBar: AppBar(
          title: Text("Forgot Password Page"),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: context.height * 0.8,
            child: Padding(padding: context.paddingMedium,
              child: Column(
                children: [
                  Expanded( flex:1,
                    child: Text("Please enter your e-mail address below to reset your password.",
                            style: Theme.of(context).textTheme.headline6)
                  ),
                  Expanded( flex: 2,
                    child:buildMailFormField(context,viewmodel, "E-mail",
                         Icon(Icons.email))
                  ),
                  Expanded( flex: 2,
                    child: buildButtons(context)
                  )
                ]
              )
            )
          ),
        ),
      ),
    );
  }

  Padding buildButtons(BuildContext context){
    return Padding(padding: context.paddingHighVertical,
      child: Row(
        children: [
          Expanded(flex: 10, child: buildSendButton()),
          Spacer(),
          Expanded(flex: 10, child: buildCancelButton()),
        ],
      ),
    );
  }

  ElevatedButton buildSendButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Center(child: Text("SEND"),),
    );
  }

  ElevatedButton buildCancelButton() {
    return ElevatedButton(
      onPressed: () {}, 
    child: Center(child: Text("CANCEL")),
    );
  }

  TextFormField buildMailFormField(BuildContext context, ForgotPasswordViewModel viewmodel, 
     String hint, Icon icon) {
    return TextFormField(
      //key: value.formState,
      autovalidateMode: AutovalidateMode.always,
      validator: (value) => viewmodel.validateEmail(value),
      //validator: (value) => emptyCheck(value),
            decoration: InputDecoration(
              hintText: hint,
              //labelText: label,
              icon: icon,
              border: UnderlineInputBorder()),
    );
  }
      
 /* String emptyCheck(String value) {
    if (value.isEmpty){
      return "E-mail is required!";
    }
    return null;
  }*/


}



