import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvanceTextFormField extends StatelessWidget {
  final String? hintText;
  final Icon? prefixIcon;
  final bool enabled;
  final bool obscureText;
  final Function? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function? validator;
  final String? initialValue;
  final Color? backgroundColor;

  const AdvanceTextFormField({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.enabled = true,
    this.obscureText = false,
    this.onChanged,
    this.keyboardType,
    this.controller,
    this.validator,
    this.initialValue,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        onChanged: (value) {
          onChanged?.call(value);
        },
        cursorColor: AppColors.red,
        style: theme.textTheme.bodyText2,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator as String? Function(String?)?,
        decoration: InputDecoration(
          fillColor: backgroundColor??AppColors.grey75.withOpacity(.15),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(10.w, 16.h, 10.w, 16.h),
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.grey800,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.grey800,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.primaryColorDark,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.errorColorDark,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.grey800,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.grey500,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          enabled: enabled,
        ),
      ),
    );
  }
}