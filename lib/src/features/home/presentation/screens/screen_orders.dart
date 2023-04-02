import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/common_appbar.dart';
import 'package:flutter_hishab_khata/src/routes/routes.dart';

class ScreenOrders extends StatelessWidget{
  const ScreenOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CommonAppBar(
        tittle: "Orders",
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
        actionWidgets: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.orderCreateScreen,);
            },
            icon: Text(
              "New Order",
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}