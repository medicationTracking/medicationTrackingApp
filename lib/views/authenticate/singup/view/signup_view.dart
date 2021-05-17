import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:medication_app_v0/core/init/text/locale_text.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import '../../../../core/base/view/base_widget.dart';
import '../viewmodel/singup_viewmodel.dart';
import '../../../../core/extention/context_extention.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import '../../../../core/extention/string_extention.dart';

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
          title: LocaleText(text: LocaleKeys.authentication_SIGNUP_PAGE),
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
                    Expanded(
                        flex: 5, child: buildSaveButton(context, viewmodel)),
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
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: LocaleKeys.authentication_MAIL_HINT_TEXT.locale,
          labelText: LocaleKeys.authentication_EMAIL.locale,
          prefixIcon: Icon(Icons.mail),
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
          hintText: LocaleKeys.authentication_PASSWORD_HINT_TEXT.locale,
          labelText: LocaleKeys.authentication_PASSWORD.locale,
          prefixIcon: Icon(Icons.lock),
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
          hintText: LocaleKeys.authentication_ID_HINT_TEXT.locale,
          labelText: LocaleKeys.authentication_ID.locale,
          prefixIcon: Icon(Icons.account_circle),
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
          hintText: LocaleKeys.authentication_NAME_HINT_TEXT.locale,
          labelText: LocaleKeys.authentication_NAME.locale,
          prefixIcon: Icon(Icons.person),
          border: buildBorder),
    );
  }

  ElevatedButton buildSaveButton(
      BuildContext context, SignupViewModel viewModel) {
    return ElevatedButton(
      onPressed: () async {
        //result message
        String registerationResult = await viewModel.userRegistration();
        //Color snackBarBackgroundColor = Colors.red;
        //if (registerationResult
        //        .compareTo(LocaleKeys.authentication_SIGNUP_SUCCESFUL.locale) ==
        //    0) {
        //  snackBarBackgroundColor = Colors.green;
        //}
        final _snackBar = SnackBar(
          content: Text(registerationResult),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      },
      child: Center(child: LocaleText(text: LocaleKeys.authentication_SAVE)),
    );
  }

  Widget buildDatePickerButton(
      SignupViewModel viewmodel, BuildContext context) {
    return Row(
      children: [
        Icon(Icons.date_range_sharp),
        LocaleText(text: LocaleKeys.authentication_BIRTHDAY),
        Expanded(
          child: TextButton(
              onPressed: () {
                viewmodel.pickDate(context);
              },
              child: Observer(
                  builder: (context) => Center(
                        child: Text(
                          viewmodel.getDate.toString(),
                          style: context.textTheme.headline6,
                        ),
                      ))),
        ),
      ],
    );
  }

  OutlineInputBorder get buildBorder => OutlineInputBorder();
}
