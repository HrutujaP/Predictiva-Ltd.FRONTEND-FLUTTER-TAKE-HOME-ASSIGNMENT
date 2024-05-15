import 'package:flutter/material.dart';
import 'package:predictiva/constants/constants.dart';
import 'package:predictiva/components/option_box.dart';
import 'package:predictiva/components/responsive_widget.dart';

// Define a stateless widget named 'Balance'
class Balance extends StatelessWidget {
  // Declare final variables to hold balance details
  final String title, value, changeValue;
  final bool change, neg;

  // Constructor for the Balance widget, with required and optional parameters
  const Balance({
    required this.title,
    required this.value,
    this.change = false,
    this.neg = false,
    this.changeValue = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // Align children to the start of the cross axis (left-aligned)
      crossAxisAlignment: CrossAxisAlignment.start,
      // Center children along the main axis
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display the balance title with specific styling
        Text(
          title,
          style: const TextStyle(
              fontSize: secondaryFontSize,
              color: primaryTextColor,
              fontWeight: secondaryFontWeight),
        ),
        SizedBox(
          height: ResponsiveWidget.isSmallScreen(context) ? 4 : 8,
        ),
        Row(
          children: [
            // Display the balance value with specific styling
            Text(
              value,
              style: TextStyle(
                fontWeight: primaryFontWeight,
                fontSize: ResponsiveWidget.isSmallScreen(context)
                    ? primaryFontSize
                    : headingFontSize,
                color: primaryTextColor,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            // Conditionally display the OptionBox widget if 'change' is true
            if (change)
              OptionBox(
                neg: neg,
                changeValue: changeValue,
                icon: true,
              ),
          ],
        )
      ],
    );
  }
}
