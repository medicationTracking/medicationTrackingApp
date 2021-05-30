import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/core/components/models/others/user_data_model.dart';
import 'package:medication_app_v0/core/components/widgets/custom_bottom_appbar.dart';
import 'package:medication_app_v0/core/components/widgets/loading_inducator.dart';
import 'package:medication_app_v0/core/constants/image/image_constants.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/init/services/auth_manager.dart';
import 'package:medication_app_v0/core/init/text/locale_text.dart';
import 'package:medication_app_v0/core/init/theme/color_theme.dart';
import 'package:medication_app_v0/views/profile/viewmodel/profile_viewmodel.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        model: ProfileViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        builder: (BuildContext context, ProfileViewModel viewModel) => Observer(
              builder: (_) => viewModel.isLoading
                  ? Scaffold(
                      body: PulseLoadingIndicatorWidget(),
                      bottomNavigationBar: CustomBottomAppBar(),
                    )
                  : buildScaffold(viewModel, context),
            ));
  }

  Scaffold buildScaffold(ProfileViewModel viewModel, BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBottomAppBar(),
        body: SingleChildScrollView(
            child: SizedBox(
                height: context.height,
                child: Column(children: [
                  Expanded(flex: 2, child: buildContainer(context)),
                  Expanded(
                      flex: 5, child: buildInformation(context, viewModel)),
                ]))));
  }

  SingleChildScrollView buildInformation(
      BuildContext context, ProfileViewModel viewModel) {
    return SingleChildScrollView(
        child: SizedBox(
            height: context.height * 0.9,
            child: Padding(
                padding: context.paddingMedium,
                child: Column(children: [
                  Expanded(flex: 5, child: buildForms(context, viewModel)),
                  Expanded(
                      flex: 1, child: buildButtonPadding(context, viewModel)),
                ]))));
  }

  Form buildForms(BuildContext context, ProfileViewModel viewModel) {
    return Form(
      key: viewModel.profileFormState,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          Expanded(flex: 1, child: buildFirstNameFormField(context, viewModel)),
          // Expanded(flex: 1, child: buildLastNameFormField(context, viewModel)),
          Expanded(flex: 1, child: buildMailFormField(context, viewModel)),
          Expanded(flex: 1, child: buildPasswordField(context, viewModel)),
          Expanded(flex: 1, child: buildAgeGenderFormField(context, viewModel)),
        ],
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
        color: ColorTheme.PRIMARY_BLUE,
        width: context.width * 1,
        child: Container(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              CircleAvatar(
                backgroundImage:
                    AssetImage(ImageConstants.instance.profileAvatar),
                radius: context.height * 0.07,
              ),
              Text(LocaleKeys.profile_PROFILE.locale,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: ColorTheme.BACKGROUND_WHITE)),
            ],
          ),
        )));
  }

  TextFormField buildFirstNameFormField(
      BuildContext context, ProfileViewModel viewModel) {
    return TextFormField(
      controller: viewModel.profileNameController,
      validator: (value) => value.isNotEmpty
          ? null
          : LocaleKeys.profile_FIRST_NAME_HINT_TEXT.locale,
      decoration: InputDecoration(
        labelText: LocaleKeys.profile_FIRST_NAME.locale,
        hintText: LocaleKeys.profile_FIRST_NAME.locale,
        border: OutlineInputBorder(),
      ),
    );
  }

  TextFormField buildMailFormField(
      BuildContext context, ProfileViewModel viewModel) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      validator: (value) => viewModel.validateEmail(value),
      controller: viewModel.profileMailController,
      decoration: InputDecoration(
          labelText: LocaleKeys.profile_MAIL.locale,
          hintText: LocaleKeys.profile_MAIL.locale,
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder()),
    );
  }

  Widget buildPasswordField(BuildContext context, ProfileViewModel viewModel) {
    return Observer(builder: (_) {
      return TextFormField(
        controller: viewModel.profilePasswordController,
        validator: (value) => viewModel.validatePassword(value),
        obscureText: !viewModel.isPasswordVisible,
        decoration: InputDecoration(
            labelText: LocaleKeys.profile_PASSWORD.locale,
            hintText: LocaleKeys.profile_PASSWORD.locale,
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: viewModel.isPasswordVisible
                  ? Icon(Icons.remove_red_eye_outlined)
                  : Icon(Icons.remove_red_eye_sharp),
              onPressed: () {
                viewModel.seePassword();
              },
            ),
            border: OutlineInputBorder()),
      );
    });
  }

  Row buildAgeGenderFormField(
      BuildContext context, ProfileViewModel viewModel) {
    return Row(children: [
      Expanded(flex: 4, child: buildAgeFormField(context, viewModel)),
      Spacer(flex: 2),
      Expanded(flex: 4, child: buildGenderFormField(context, viewModel)),
    ]);
  }

  TextFormField buildAgeFormField(
      BuildContext context, ProfileViewModel viewModel) {
    return TextFormField(
        validator: (value) =>
            value.isNotEmpty ? null : LocaleKeys.profile_AGE_HINT_TEXT.locale,
        controller: viewModel.profileAgeController,
        decoration: InputDecoration(
          labelText: LocaleKeys.profile_AGE.locale,
          hintText: LocaleKeys.profile_AGE.locale,
          border: UnderlineInputBorder(),
        ));
  }

  DropdownButton buildGenderFormField(
      BuildContext context, ProfileViewModel viewModel) {
    return DropdownButton<String>(
        value: viewModel.chosenValue,
        items: <String>[
          LocaleKeys.profile_FEMALE.locale,
          LocaleKeys.profile_MALE.locale,
          LocaleKeys.profile_OTHER.locale,
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hint: Text(LocaleKeys.profile_GENDER.locale),
        onChanged: (String value) {
          setState(() {
            viewModel.chosenValue = value;
          });
        });
  }

  Padding buildButtonPadding(BuildContext context, ProfileViewModel viewModel) {
    return Padding(
        padding: context.paddingMedium, child: buildButton(context, viewModel));
  }

  ElevatedButton buildButton(BuildContext context, ProfileViewModel viewModel) {
    return ElevatedButton(
      child: Center(
          child: LocaleText(text: LocaleKeys.profile_SAVE_BUTTON.locale)),
      onPressed: () {
        print("mail:" +
            viewModel.profileMailController.text +
            " password:" +
            viewModel.profilePasswordController.text);
      },
      //EGER BELIRLEDIGIMIZ TEMA DISINDA BIR RENK VERMEK ISTERSEK COPYWITH DEYIP O SPESIFIK OZELLIGI DEGISTIRIYORUZ.
      style: Theme.of(context).elevatedButtonTheme.style.copyWith(
          backgroundColor:
              MaterialStateProperty.all<Color>(ColorTheme.PRIMARY_BLUE)),
    );
  }
}
