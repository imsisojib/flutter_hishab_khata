import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextEditFormCardView extends StatefulWidget {
  final String? initialValue;
  final String? hintText;
  final String? tittleText;
  final TextStyle? tittleTextStyle;
  final String? additionalTittleText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Function? onChanged;
  final bool isPassword;
  final bool isMandatoryField;
  final Color enableBorderColor;
  final Color? backgroundColor;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;

  ///Reason to make this component: basically we need textfield with tittle. so here it is.
  ///tittleText: if it is null, then tittle won't be shown.
  ///isPassword is false by default
  ///isPasswordVisible is false by default
  const TextEditFormCardView({
    Key? key,
    this.tittleText,
    this.additionalTittleText,
    this.controller,
    this.inputType,
    this.hintText,
    this.onChanged,
    this.isPassword = false,
    this.isMandatoryField = false,
    this.enableBorderColor = Colors.transparent,
    this.tittleTextStyle,
    this.backgroundColor,
    this.initialValue,
    this.textAlign,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TextEditFormCardViewState();
  }
}

class _TextEditFormCardViewState extends State<TextEditFormCardView> {
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
                    color: AppColors.grey400,
                  ),
                ),
                TextFormField(
                  inputFormatters: widget.inputFormatters,
                  initialValue: widget.initialValue,
                  onChanged: (value) {
                    if (widget.onChanged != null) widget.onChanged!(value);
                  },
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500,),
                  textAlign: widget.textAlign ?? TextAlign.start,
                  obscureText: widget.isPassword && !isPasswordVisible,
                  controller: widget.controller,
                  keyboardType: widget.inputType,
                  decoration: InputDecoration(
                    fillColor: widget.backgroundColor ?? Colors.transparent,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(0, 8.h, 16.w, 8.h),
                    isDense: true,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.grey400,
                    ),
                  ),
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
