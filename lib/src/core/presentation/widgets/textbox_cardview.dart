import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextBoxCardView extends StatefulWidget {
  final String? initialValue;
  final String? hintText;
  final String? tittleText;
  final TextStyle? tittleTextStyle;
  final String? additionalTittleText;
  final Color enableBorderColor;
  final Color? backgroundColor;
  final TextAlign? textAlign;

  ///Reason to make this component: basically we need textfield with tittle. so here it is.
  ///tittleText: if it is null, then tittle won't be shown.
  ///isPassword is false by default
  ///isPasswordVisible is false by default
  const TextBoxCardView({
    Key? key,
    this.tittleText,
    this.additionalTittleText,
    this.hintText,
    this.enableBorderColor = Colors.transparent,
    this.tittleTextStyle,
    this.backgroundColor,
    this.initialValue,
    this.textAlign,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TextBoxCardViewState();
  }
}

class _TextBoxCardViewState extends State<TextBoxCardView> {
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      elevation: 3,
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.tittleText ?? "",
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppColors.grey500,
                  ),
                ),
                SizedBox(height: 4.h,),
                Text(
                  widget.initialValue??"",
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500,),
                ),
              ],
            ),),
            //Icon(Icons.check, color: AppColors.green, size: 16,),
          ],
        ),
      ),
    );
  }
}
