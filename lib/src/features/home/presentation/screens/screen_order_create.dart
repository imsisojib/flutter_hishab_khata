import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/common_appbar.dart';

class ScreenOrderCreate extends StatelessWidget{
  const ScreenOrderCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        tittle: "Create Order",
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
      ),
    );
  }
}