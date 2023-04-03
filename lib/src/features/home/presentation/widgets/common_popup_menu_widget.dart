import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonPopupMenuWidget extends StatelessWidget{
  final String? name;
  final IconData iconData;
  const CommonPopupMenuWidget({Key? key, this.name, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          Icon(iconData,color: AppColors.grey600,size: 16,),
          SizedBox(width: 8.w,),
          Text(name??"",style: theme.textTheme.bodySmall,),
        ],
      ),
    );
  }

}