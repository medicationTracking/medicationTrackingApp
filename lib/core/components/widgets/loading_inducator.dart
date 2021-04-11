import 'package:flutter/material.dart';

import 'lottie_widget.dart';

class PulseLoadingIndicatorWidget extends StatelessWidget {
  const PulseLoadingIndicatorWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(child: LottieCustomWidget(path: "pulse_green"));
  }
}
