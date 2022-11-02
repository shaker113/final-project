import 'package:flutter/material.dart';
import 'package:fina/data/data.dart';

class GradientButton extends StatelessWidget {
  final String theText;
  final Function() theFunction;
  const GradientButton(
      {super.key, required this.theFunction, required this.theText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: screenWidth! * 0.8,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        gradient: RadialGradient(
          radius: 6,
          center: Alignment.center,
          colors: [buttonsColor, backgrounColor2.withOpacity(0.4)],
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(screenWidth! * 0.8, 50),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        ),
        onPressed: theFunction,
        child: Text(
          theText,
          style: customTextStyle.labelMedium,
        ),
      ),
    );
  }
}
