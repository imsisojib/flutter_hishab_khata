import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  final Color activeColor;
  final Color inactiveColor;

  const CheckBoxWidget(
      {super.key,
      required this.value,
      this.onChanged,
      required this.activeColor,
      required this.inactiveColor});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor,
    );
  }
}
