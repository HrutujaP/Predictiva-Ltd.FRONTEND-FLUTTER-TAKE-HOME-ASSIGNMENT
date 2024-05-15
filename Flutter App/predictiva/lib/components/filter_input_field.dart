import 'package:flutter/material.dart';
import 'package:predictiva/constants/constants.dart';

class FilterInputField extends StatelessWidget {
  final Function onChange;
  final String? Function(String?)? validator;
  final String hintText;
  final bool icon;
  final TextInputType keyboardType;

  const FilterInputField({
    required this.onChange,
    required this.hintText,
    required this.keyboardType,
    required this.validator,
    this.icon = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.39,
      decoration: boxDecoration,
      child: TextFormField(
        onChanged: (value) {
          onChange(value);
        },
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: optionFontSize,
              color: secondaryTextColor,
              fontWeight: secondaryFontWeight),
          filled: true,
          fillColor: boxColor,
          suffixIcon: icon
              ? const Icon(Icons.calendar_today_outlined,
                  color: primaryTextColor, size: primaryFontSize)
              : null,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        keyboardType: keyboardType,
        style: const TextStyle(
            fontSize: optionFontSize,
            color: primaryTextColor,
            fontWeight: secondaryFontWeight),
      ),
    );
  }
}
