import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';

class ButtonStroke extends StatelessWidget {
  final Function? function;
  final Color? strokeColor;
  final String? buttonText;
  final Color? buttonColor;
  final double width;
  final double height;
  final double borderRadius;
  final TextStyle? buttonTextStyle;
  final double strokeWidth;

  const ButtonStroke(
      {Key? key,
      this.buttonText,
      this.buttonColor,
      this.width = 100,
      this.height = 48,
      this.borderRadius = 25,
      this.buttonTextStyle,
      this.function,
      this.strokeColor,
      this.strokeWidth = 1,
      }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: buttonColor ?? Colors.transparent,
          border: Border.all(
            color: strokeColor ?? AppColors.red,
            width: strokeWidth,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          function?.call();
        },
        child: Text(
          buttonText ?? "",
          style: buttonTextStyle??theme.textTheme.bodyMedium,
        ),
      ),
    );
  }
}
