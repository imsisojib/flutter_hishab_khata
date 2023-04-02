import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';
import 'package:flutter_hishab_khata/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String tittle;
  final List<Widget>? actionWidgets;

  const CommonAppBar({
    super.key,
    this.actionWidgets,
    required this.tittle,
    required this.preferredSize,
  });

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  final Size preferredSize;
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        height: kToolbarHeight.h + 16,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.scaffoldColorLight,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(.3),
              blurRadius: 12,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Text(
              widget.tittle,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 24,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.homeScreen,
                        (route) => false,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.black,
                    size: 24.h,
                  ),
                ),
                widget.actionWidgets == null
                    ? SizedBox(
                        width: 24.h,
                        height: 24.h,
                      )
                    : Row(
                        children: widget.actionWidgets!,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Size get preferredSize => calculateSize();

  Size calculateSize() {
    return Size(MediaQuery.of(context).size.width, kToolbarHeight);
  }
}
