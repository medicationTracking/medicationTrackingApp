import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/base/view/base_widget.dart';
import 'package:medication_app_v0/views/home/viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      model: HomeViewmodel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      builder: (context, value) => Scaffold(
          appBar: AppBar(
            title: Text("Home Page"),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.amber,
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  color: Colors.black,
                ),
              ),
            ],
          )),
    );
  }
}
