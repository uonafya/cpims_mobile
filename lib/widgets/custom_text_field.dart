import 'package:cpims_mobile/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.onChanged,
      this.labelText,
      this.prefixIcon,
      this.textInputAction,
      this.suffixIcon,
      this.initialValue,
      this.controller,
      this.validator,
      this.enabled,
      this.hintText,
      this.keyboardType})
      : super(key: key);

  final String? labelText;
  final String? hintText;
  final Function(String val)? onChanged;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputAction? textInputAction;
  final String? Function(String? val)? validator;
  final bool? enabled;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (val) {
        if (onChanged != null) {
          onChanged!(val);
        }
      },
      validator: validator,
      controller: controller,
      enabled: enabled,
      initialValue: initialValue,
      cursorColor: kPrimaryColor,
      textInputAction: textInputAction,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 14),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey[500]!),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: 20,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? Icon(
                suffixIcon,
                size: 20,
              )
            : null,
      ),
    );
  }
}
