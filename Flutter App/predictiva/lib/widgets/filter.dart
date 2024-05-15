import 'package:flutter/material.dart';
import 'package:predictiva/constants/constants.dart';
import 'package:predictiva/components/filter_dropdown.dart';
import 'package:predictiva/components/filter_input_field.dart';

// Define a stateless widget named 'Filter'
class Filter extends StatelessWidget {
  // Function to filter the table and a list of dropdown menu entries for symbols
  final Function filterTable;
  final List<DropdownMenuEntry> _symbols;
  // Constructor for the Filter widget, initializing required parameters
  const Filter({
    required this.filterTable,
    required List<DropdownMenuEntry> symbols,
    super.key,
  }) : _symbols = symbols;

  @override
  Widget build(BuildContext context) {
    // Variables to hold the selected filter values
    String selectedSymbol = '';
    String selectedPrice = '';
    String selectedStartDate = '';
    String selectedEndDate = '';

    // Global key for the form to handle validation
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // Regular expressions for validating date and price inputs
    const String dateRegex = r'^\d{2}/\d{2}/\d{4}$';
    const String priceRegex = r'^\d*\.?\d+$';

    // Function to validate date inputs
    String? validateDate(String? value) {
      return RegExp(dateRegex).hasMatch(value!) || value.isEmpty
          ? null
          : 'Use DD/MM/YYYY format';
    }

    // Return an AlertDialog with a form containing filter options
    return Form(
      key: formKey,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.all(0),
        content: Builder(
          builder: (context) {
            return Container(
              decoration: boxDecoration,
              height: 300,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        FilterDropDown(
                            symbols: _symbols,
                            onSelected: (value) {
                              selectedSymbol = value;
                            }),
                        const Spacer(),
                        FilterInputField(
                          onChange: (value) {
                            selectedPrice = value;
                          },
                          validator: (value) {
                            return RegExp(priceRegex).hasMatch(value!) ||
                                    value.isEmpty
                                ? null
                                : 'Invalid Price';
                          },
                          hintText: 'Price',
                          keyboardType: TextInputType.number,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Date Range',
                        style: TextStyle(
                            fontSize: optionFontSize,
                            color: primaryTextColor,
                            fontWeight: primaryFontWeight)),
                    Row(
                      children: [
                        FilterInputField(
                          onChange: (value) => selectedStartDate = value,
                          validator: validateDate,
                          hintText: 'Start Date',
                          keyboardType: TextInputType.text,
                          icon: true,
                        ),
                        const Spacer(),
                        FilterInputField(
                          onChange: (value) => selectedEndDate = value,
                          validator: validateDate,
                          hintText: 'End Date',
                          keyboardType: TextInputType.text,
                          icon: true,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            filterTable(selectedSymbol, selectedPrice,
                                selectedStartDate, selectedEndDate);
                            Navigator.of(context).pop();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(buttonColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                          ),
                        ),
                        child: const Text('Filter Table',
                            style: TextStyle(
                                fontSize: secondaryFontSize,
                                color: primaryTextColor,
                                fontWeight: primaryFontWeight)),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
