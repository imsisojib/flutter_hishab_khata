import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicTextBox extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final String? tittleText;
  final TextStyle? tittleTextStyle;
  final String? additionalTittleText;
  final bool isMandatoryField;
  final Color enableBorderColor;
  final Color? backgroundColor;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? padding;
  const BasicTextBox(
      {Key? key,
      this.tittleText,
      this.additionalTittleText,
      this.isMandatoryField = false,
      this.enableBorderColor = AppColors.grey400,
      this.tittleTextStyle,
      this.backgroundColor,
      this.textAlign,
      this.text,
      this.style,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: tittleText == null ? false : true,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          tittleText ?? "",
                          style: tittleTextStyle ?? theme.textTheme.titleMedium,
                        ),
                        isMandatoryField
                            ? Text(
                                "*",
                                style: theme.textTheme.labelSmall,
                              )
                            : Text(""),
                        Text(
                          additionalTittleText ?? "",
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
              ],
            )),
        Container(
          height: 54.h,
          width: MediaQuery.of(context).size.width,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
          decoration: BoxDecoration(
            border: Border.all(color: enableBorderColor),
            borderRadius: BorderRadius.circular(4),
            color: backgroundColor,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text ?? "",
              style: style ?? theme.textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
}
