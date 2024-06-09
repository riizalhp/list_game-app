import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../theme.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: LoadingAnimationWidget.inkDrop(
        color: kGreenColor,
        size: 50,
      ),
    ));
  }
}
