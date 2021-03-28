import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:medication_app_v0/core/base/state/base_state.dart';
import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/views/test/viewmodel/test_viewmodel.dart';

class TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends BaseState<TestView> {
  TestViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView<TestViewModel>(
      model: TestViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      builder: (context, value) => scaffoldBody,
    );
  }

  Widget get scaffoldBody => Scaffold(
        floatingActionButton: buildFloatingActionButton(),
        body: buildNumberText,
      );

  Widget get buildNumberText =>
      Observer(builder: (context) => Text(viewModel.number.toString()));

  FloatingActionButton buildFloatingActionButton() => FloatingActionButton(
        onPressed: () => viewModel.incNumber(),
      );
}
