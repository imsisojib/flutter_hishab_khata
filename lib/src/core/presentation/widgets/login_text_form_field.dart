import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginTextFomrFiledWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final Color? cursorColor;
  final TextInputType? textInputType;
  final TextInputFormatter? textInputFormatter;
  final String hintText;
  final String labelText;
  final Icon? prefixIcon;
  final IconButton? sufixIcon;
  final bool? obscureText;
  final String? initialValue;
  final Function? onChanged;

  const LoginTextFomrFiledWidget({
    super.key,
    required this.textEditingController,
    this.cursorColor,
    this.textInputType,
    this.textInputFormatter,
    required this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.sufixIcon,
    this.obscureText,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: textEditingController,
      onChanged: (String value){
        onChanged?.call(value);
      },
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      style: const TextStyle(color: Colors.black87, fontSize: 18),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(25.0),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 154, 205, 212),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.brown, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 15, color: Colors.white),
        label: Text(
          labelText,
          style: theme.textTheme.bodyMedium,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: sufixIcon,
        focusColor: Colors.black,
        prefixIconColor: Colors.blueGrey,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      ),
      cursorColor: Colors.black,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [],
    );
  }
}
