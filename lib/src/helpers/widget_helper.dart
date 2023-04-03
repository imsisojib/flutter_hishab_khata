import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/di_container.dart';
import 'package:flutter_hishab_khata/src/core/application/navigation_service.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/button_filled.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/button_stroke.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetHelper{
  static void showDialogForConfirmation({
    required String title,
    required String description,
    required Function onPositiveAction,
  }) {
    final theme =
    Theme.of(sl<NavigationService>().navigatorKey.currentContext!);
    showDialog(
      barrierLabel: "ConfirmationDialog",
      //barrierColor: Colors.transparent,
      context: sl<NavigationService>().navigatorKey.currentContext!,
      builder: (context) {
        return _BlurryDialog(
          alertDialog: AlertDialog(
            backgroundColor: theme.cardColor,
            shadowColor: const Color(0xff6B3CB0).withOpacity(.7),
            elevation: 7,
            //backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                strokeAlign: 2,
                style: BorderStyle.solid,
                color: Color(0xff8148C3),
              ),
            ),
            title: Text(
              title,
              style: theme.textTheme.bodyText2
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            //titlePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //insetPadding: EdgeInsets.zero,
            buttonPadding: const EdgeInsets.all(16),
            content: Text(
              description,
              style: theme.textTheme.bodyText2,
            ),
            actionsAlignment: MainAxisAlignment.end,
            actions: <Widget>[
              ButtonStroke(
                strokeWidth: 1,
                height: 30.h,
                width: 70.w,
                strokeColor: const Color(0xff5A4080),
                function: () {
                  Navigator.pop(context);
                },
                buttonText: 'No',
                buttonTextStyle: theme.textTheme.bodySmall,
              ),
              ButtonFilled(
                height: 30.h,
                width: 70.w,
                buttonText: "Yes",
                function: () {
                  Navigator.pop(context);
                  onPositiveAction.call();
                },
                buttonTextStyle: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textColorDark
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showDialogWithDynamicContent({
    required Widget content,
  }) {
    final theme =
    Theme.of(sl<NavigationService>().navigatorKey.currentContext!);
    showDialog(
      barrierLabel: "ConfirmationDialog",
      //barrierColor: Colors.transparent,
      context: sl<NavigationService>().navigatorKey.currentContext!,
      builder: (context) {
        return _BlurryDialog(
          alertDialog: AlertDialog(
            backgroundColor: theme.cardColor,
            shadowColor: const Color(0xff6B3CB0).withOpacity(.7),
            elevation: 7,
            //backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                strokeAlign: 2,
                style: BorderStyle.solid,
                color: Color(0xff8148C3),
              ),
            ),
            //titlePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //insetPadding: EdgeInsets.zero,
            buttonPadding: const EdgeInsets.all(16),
            content: content,
          ),
        );
      },
    );
  }


}

class _BlurryDialog extends StatelessWidget {
  final AlertDialog alertDialog;

  const _BlurryDialog({
    required this.alertDialog,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: alertDialog,
    );
  }
}