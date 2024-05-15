import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:predictiva/constants/constants.dart';
import 'package:predictiva/model/portfolio.dart';
import 'package:predictiva/widgets/balance.dart';
import 'package:http/http.dart' as http;
import 'package:predictiva/components/responsive_widget.dart';


// StatefulWidget representing the Summary section of the app.
class Summary extends StatefulWidget {
  const Summary({
    super.key,
  });

  @override
  State<Summary> createState() => _SummaryState();
}
// State class for the Summary widget.
class _SummaryState extends State<Summary> {
  bool _isLoading = false;
  late Portfolio portfolio;

  // initState method to initialize state and fetch data.
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  // Asynchronous method to fetch portfolio data from an API.
  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(portfolioAPI));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data']['portfolio'];
      portfolio = Portfolio.fromJson(data);
    } else {
      // Displaying a snack bar in case of error during data fetching.
      SnackBar(content: Text('Error fetching data: ${response.statusCode}'));
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Build method to create the UI for the Summary widget.
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: boxDecoration,
        height: ResponsiveWidget.isSmallScreen(context)
            ? MediaQuery.of(context).size.height * 0.425
            : MediaQuery.of(context).size.height * 0.35,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        decoration: const BoxDecoration(
                          color: boxColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(borderRadius),
                              topRight: Radius.circular(borderRadius)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: ResponsiveWidget.isSmallScreen(context)
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Displaying balance, profits, and assets for small screens.
                                    Balance(
                                        title: 'Balance',
                                        value:
                                            '\$${portfolio.balance.toStringAsFixed(2)}'),
                                    lineDivider,
                                    Balance(
                                        title: 'Profits',
                                        value:
                                            '\$${portfolio.profit.toStringAsFixed(2)}',
                                        change: true,
                                        neg: portfolio.isLoss,
                                        changeValue:
                                            '${portfolio.profitPercentage}%'),
                                    lineDivider,
                                    Balance(
                                        title: 'Assets',
                                        value: portfolio.assets.toString()),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Displaying balance, profits, and assets for large screens.
                                    Balance(
                                        title: 'Balance',
                                        value: '\$${portfolio.balance}'),
                                    verticalLineDivider,
                                    Balance(
                                        title: 'Profits',
                                        value: '\$${portfolio.profit}',
                                        change: true,
                                        neg: portfolio.isLoss,
                                        changeValue:
                                            '${portfolio.profitPercentage}%'),
                                    verticalLineDivider,
                                    Balance(
                                        title: 'Assets',
                                        value: portfolio.assets.toString()),
                                  ],
                                ),
                        ),
                      )),

            // Displaying a message about subscription expiration.
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded,
                        color: cautionColor, size: 20),
                    SizedBox(
                      width: 8,
                    ),
                    Text('This Subscription expires in a month',
                        style: TextStyle(
                            fontSize: secondaryFontSize,
                            fontWeight: secondaryFontWeight,
                            color: primaryTextColor)),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
