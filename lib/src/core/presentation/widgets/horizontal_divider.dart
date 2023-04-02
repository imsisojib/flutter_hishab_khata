import 'package:flutter/cupertino.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';

class HorizontalDivider extends StatelessWidget{
  final Color? color;
  final double? height;
  const HorizontalDivider({Key? key, this.color, this.height=1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      color: color??AppColors.grey400,
    );
  }

}