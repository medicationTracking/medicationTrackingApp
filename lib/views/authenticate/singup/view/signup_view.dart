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
              child: Form(
                key: viewmodel.singupFormState,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Expanded(
                      flex: 10,
                      child: buildTextFormFieldName(viewmodel),
                    ),
                    Expanded(
                      flex: 10,
                      child: buildTextFormFieldId(viewmodel),
                    ),
                    Expanded(
                      flex: 10,
                      child: buildTextFormFieldPassword(viewmodel),
                    ),
                    Expanded(
                      flex: 10,
                      child: buildTextFormFieldMail(viewmodel),
                    ),
                    Expanded(
                        flex: 7,
                        child: buildDatePickerButton(viewmodel, context)),
                    Expanded(flex: 5, child: buildSaveButton(viewmodel)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormFieldMail(viewmodel) {
    return TextFormField(
      controller: viewmodel.mailController,
      validator: (value) => (viewmodel.validateEmail(value)),
      onSaved: (value) {
        viewmodel.mailController = value;
      },
      decoration: InputDecoration(
          hintText: "enter your mail",
          labelText: "Mail",
          icon: Icon(Icons.mail),
          border: buildBorder),
    );
  }

  TextFormField buildTextFormFieldPassword(viewmodel) {
    return TextFormField(
      controller: viewmodel.passwordController,
      validator: (value) => (viewmodel.emptyCheck(value)),
      onSaved: (value) {
        viewmodel.passwordController = value;
      },
      obscureText: true,
      decoration: InputDecoration(
          hintText: "enter your password",
          labelText: "Password",
          icon: Icon(Icons.lock),
          border: buildBorder),
    );
  }

  TextFormField buildTextFormFieldId(viewmodel) {
    return TextFormField(
      controller: viewmodel.idController,
      validator: (value) => (viewmodel.emptyCheck(value)),
      onSaved: (value) {
        viewmodel.idController = value;
      },
      decoration: InputDecoration(
          hintText: "enter your id",
          labelText: "ID",
          icon: Icon(Icons.account_circle),
          border: buildBorder),
    );
  }

  TextFormField buildTextFormFieldName(viewmodel) {
    return TextFormField(
      controller: viewmodel.nameController,
      validator: (value) => (viewmodel.emptyCheck(value)),
      onSaved: (value) {
        viewmodel.nameController = value;
      },
      decoration: InputDecoration(
          hintText: "enter your name",
          labelText: "Name",
          icon: Icon(Icons.person),
          border: buildBorder),
    );
  }

  ElevatedButton buildSaveButton(SignupViewModel viewModel) {
    return ElevatedButton(
      onPressed: () {
        print("name:" +
            viewModel.nameController.text +
            " " +
            "id:" +
            viewModel.idController.text +
            " " +
            "password:" +
            viewModel.passwordController.text +
            " " +
            "mail:" +
            viewModel.mailController.text);
      },
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

  OutlineInputBorder get buildBorder => OutlineInputBorder();
}
