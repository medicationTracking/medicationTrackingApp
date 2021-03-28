import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/base/view/base_widget.dart';
import '../viewmodel/singup_viewmodel.dart';
import '../../../../core/extention/context_extention.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      model: SignupViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      builder: (context, viewmodel) => Scaffold(
        appBar: AppBar(
          title: Text("Singup Page"),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: context.height * 0.8,
            child: Padding(
              padding: context.paddingMedium,
              child: Column(
                children: [
                  Expanded(
                      flex: 20,
                      child: buildFormField(context, viewmodel, "ID",
                          "Enter your ID", Icon(Icons.account_circle))),
                  Expanded(
                      flex: 20,
                      child: buildFormField(context, viewmodel, "Password",
                          "Enter your password", Icon(Icons.lock))),
                  Expanded(
                      flex: 20,
                      child: buildFormField(context, viewmodel, "Email",
                          "Enter your e-mail", Icon(Icons.mail))),
                  Expanded(
                      flex: 20,
                      child: buildFormField(context, viewmodel, "Name",
                          "Enter your name", Icon(Icons.person))),
                  Expanded(
                      flex: 20,
                      child: buildDatePickerButton(viewmodel, context)),
                  Expanded(flex: 10, child: buildSaveButton()),
                ],
              ),
            ),
          ),
        ),
        /*ListView(
          padding: context.paddingMediumHorizontal,
          children: [
            buildFormField(context, viewmodel, "ID", "Enter your id",
                Icon(Icons.account_circle)),
            buildFormField(context, viewmodel, "Password",
                "Enter your password", Icon(Icons.lock)),
            buildFormField(context, viewmodel, "Email", "Enter your e-mail",
                Icon(Icons.mail)),
            buildFormField(context, viewmodel, "Name", "Enter your name",
                Icon(Icons.person)),
            buildDatePickerButton(viewmodel, context),
            buildSaveButton(),
          ],
        ),*/
      ),
    );
  }

  ElevatedButton buildSaveButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Center(child: Text("SAVE")),
    );
  }

  TextButton buildDatePickerButton(viewmodel, BuildContext context) {
    return TextButton(
        onPressed: () {
          viewmodel.pickDate(context);
        },
        child: Row(
          children: [
            Icon(Icons.date_range_sharp),
            Observer(
                builder: (context) => Center(
                      child: Text(
                        viewmodel.getDate.toString(),
                        style: context.textTheme.headline6,
                      ),
                    )),
          ],
        ));
  }

  TextFormField buildFormField(BuildContext context, SignupViewModel viewmodel,
      String hint, String label, Icon icon) {
    return TextFormField(
      validator: (value) => emptyCheck(value),
      decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          icon: icon,
          border: UnderlineInputBorder()),
    );
  }

  String emptyCheck(String value) {
    if (value.isEmpty) {
      return "This form required!";
    }
    return null;
  }
}
