import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomAnimation extends StatelessWidget {
  Widget ?widget;
      int? num;
  CustomAnimation(this.widget,this.num, {super.key});
  @override
  Widget build(BuildContext context) {
    return FadeInUp( delay: Duration(milliseconds:num! ), child: widget!,);
  }
}
