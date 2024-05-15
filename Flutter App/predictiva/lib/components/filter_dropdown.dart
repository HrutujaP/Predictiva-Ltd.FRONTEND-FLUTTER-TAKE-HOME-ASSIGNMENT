import 'package:flutter/material.dart';
import 'package:predictiva/constants/constants.dart';

class FilterDropDown extends StatelessWidget {
  final Function onSelected;
  const FilterDropDown({
    required this.onSelected,
    required List<DropdownMenuEntry> symbols,
    super.key,
  }) : _symbols = symbols;

  final List<DropdownMenuEntry> _symbols;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        width: MediaQuery.of(context).size.width * 0.39,
        menuStyle: MenuStyle(
          backgroundColor: const MaterialStatePropertyAll(boxColor),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius))),
        ),
        menuHeight: 400,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: boxColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        label: const Text('Symbol',
            style: TextStyle(
                fontSize: optionFontSize,
                color: primaryTextColor,
                fontWeight: secondaryFontWeight)),
        onSelected: (value) {
          onSelected(value);
        },
        trailingIcon: Transform.rotate(
          angle: 3.14159 * 1.5,
          child: const Icon(Icons.arrow_back_ios_rounded,
              color: primaryTextColor, size: optionFontSize),
        ),
        selectedTrailingIcon: Transform.rotate(
          angle: 3.14159 / 2,
          child: const Icon(Icons.arrow_back_ios_rounded,
              color: primaryTextColor, size: optionFontSize),
        ),
        textStyle: const TextStyle(
            fontSize: optionFontSize,
            color: primaryTextColor,
            fontWeight: secondaryFontWeight),
        dropdownMenuEntries: _symbols);
  }
}