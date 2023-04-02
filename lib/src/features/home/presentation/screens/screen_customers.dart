import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/common_appbar.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';
import 'package:flutter_hishab_khata/src/routes/routes.dart';

class ScreenCustomers extends StatelessWidget{
  const ScreenCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CommonAppBar(
        tittle: "Customers",
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
        actionWidgets: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.customerCreateScreen,);
            },
            icon: Text(
              "Add New",
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