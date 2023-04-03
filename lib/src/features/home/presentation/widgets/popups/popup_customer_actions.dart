import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/button_stroke.dart';

class PopupCustomerActions extends StatelessWidget {
  final Function? onViewOrders;

  const PopupCustomerActions({
    super.key,
    this.onViewOrders,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Choose Option",
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ButtonStroke(
          function: () {
            Navigator.pop(context);
            onViewOrders?.call();
          },
          buttonText: "View All Orders",
        ),
      ],
    );
  }
}
