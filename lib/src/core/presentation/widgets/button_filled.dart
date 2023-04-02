import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonFilled extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? shadowColor;
  final double? width;
  final double height;
  final double borderRadius;
  final TextStyle? buttonTextStyle;
  final Function? function;
  final Icon? prefixIcon;
  final EdgeInsetsGeometry? buttonPadding;

  ///do not use route and function at the same time. Only once can be perform at a time in the ButtonFilled
  const ButtonFilled({
    Key? key,
    this.buttonText,
    this.buttonColor,
    this.shadowColor,
    this.width,
    this.height = 48,
    this.borderRadius = 25,
    this.buttonTextStyle,
    this.function,
    this.prefixIcon,
    this.buttonPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height.h,
      decoration: BoxDecoration(
        color: buttonColor ?? AppColors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? const Color.fromRGBO(211, 38, 38, 0.25),
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(0, 2),
          )
        ]
      ),
      child: MaterialButton(
        padding: buttonPadding,
        onPressed: () {
          function?.call();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIcon ?? Container(),
            prefixIcon != null
                ? SizedBox(
                    width: 4.w,
                  )
                : Container(),
            Flexible(
              child: Text(
                buttonText ?? "",
                style: buttonTextStyle ??
                    theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
