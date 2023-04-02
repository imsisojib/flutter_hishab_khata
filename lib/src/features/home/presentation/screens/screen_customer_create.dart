import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/common_appbar.dart';

class ScreenCustomerCreate extends StatelessWidget{
  const ScreenCustomerCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        tittle: "Add Customer",
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
      ),
    );
  }
}