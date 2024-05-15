import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:predictiva/constants/constants.dart';
import 'package:predictiva/model/order.dart';
import 'package:predictiva/components/option_box.dart';
import 'package:predictiva/components/responsive_widget.dart';
import 'package:predictiva/components/text_data.dart';


// Define a stateless widget named 'Trade'
class Trade extends StatelessWidget {
  // Order model object to hold order details
  final Order order;

  // Constructor for the Trade widget, initializing the required order parameter
  const Trade({
    required this.order,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the screen size is small to determine the layout
    return ResponsiveWidget.isSmallScreen(context)
        ? Row(
            // If the screen is small, use a Row with nested Columns for layout

            children: [
              Column(
                // Column to display symbol and side
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.symbol,
                    style: const TextStyle(
                        fontSize: secondaryFontSize,
                        fontWeight: primaryFontWeight,
                        color: primaryTextColor),
                  ),
                  OptionBox(neg: true, changeValue: order.side)
                ],
              ),
              const Spacer(),
              // Column to display price and creation time
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    order.price.toString(),
                    style: const TextStyle(
                        fontSize: secondaryFontSize,
                        fontWeight: secondaryFontWeight,
                        color: primaryTextColor),
                  ),
                  Text(
                    DateFormat('d MMM, yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            order.creationTime)),
                    style: const TextStyle(
                        fontSize: secondaryFontSize,
                        fontWeight: secondaryFontWeight,
                        color: secondaryTextColor),
                  ),
                ],
              )
            ],
          )
        : // If the screen is not small, use a Container with a Row for layout
        Container(
            decoration: boxDecoration,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Expanded widgets to evenly distribute space among children
                  Expanded(
                    flex: 1,
                    child: TextData(value: order.symbol),
                  ),
                  Expanded(
                    child: TextData(value: order.price.toString()),
                  ),
                  Expanded(
                    child: TextData(value: order.type),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: OptionBox(neg: true, changeValue: order.side)),
                  ),
                  Expanded(
                    child: TextData(value: order.quantity.toString()),
                  ),
                  Expanded(
                    child: TextData(
                      value: DateFormat('d MMM, yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          order.creationTime,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
