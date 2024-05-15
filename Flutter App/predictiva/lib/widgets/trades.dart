import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:predictiva/constants/constants.dart';
import 'package:predictiva/model/order.dart';
import 'package:predictiva/widgets/filter.dart';
import 'package:predictiva/components/responsive_widget.dart';
import 'package:predictiva/components/table_header.dart';
import 'package:predictiva/components/text_data.dart';
import 'package:predictiva/widgets/trade.dart';
import 'package:http/http.dart' as http;

// Define a stateful widget named 'Trades'
class Trades extends StatefulWidget {
  const Trades({
    super.key,
  });

  @override
  State<Trades> createState() => _TradesState();
}

class _TradesState extends State<Trades> {
  // Lists to hold Trade objects and symbols
  List<Trade> _orders = [];
  List<Trade> _allOrders = [];
  List<DropdownMenuEntry> _symbols = [];
  bool _isLoading = false;

  @override
  
  void initState() {
    super.initState();
    _fetchData(); // Fetch data when the widget is initialized
  }


  // Method to fetch data from the API
  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(Uri.parse(openOrdersAPI));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data']['orders'] as List;
      _allOrders = data.map((e) => Trade(order: Order.fromJson(e))).toList();
      _orders = _allOrders;

      // Create dropdown menu entries from symbols
      _symbols = data
          .map((e) => DropdownMenuEntry(
              value: e['symbol'],
              label: e['symbol'],
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                foregroundColor: MaterialStateProperty.all(primaryTextColor),
              )))
          .toList();
    } else {
      // Show error message if data fetching fails
      SnackBar(content: Text('Error fetching data: ${response.statusCode}'));
    }
    setState(() {
      _isLoading = false;
    });
  }

  // Helper method to convert date string to epoch time
  int dateToEpoch(String date) {
    List<String> dateParts = date.split('/');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);
    return DateTime(year, month, day).millisecondsSinceEpoch;
  }

  // Method to filter the table based on given criteria
  void _filterTable(
      String symbol, String price, String startDate, String endDate) {
    List<Trade> filteredOrders = _allOrders;
    if (symbol.isNotEmpty) {
      filteredOrders = filteredOrders
          .where((trade) => trade.order.symbol == symbol)
          .toList();
    }

    if (price.isNotEmpty) {
      final double priceValue = double.parse(price);
      filteredOrders = filteredOrders
          .where((trade) => trade.order.price == priceValue)
          .toList();
    }

    if (startDate.isNotEmpty) {
      final int startTime = dateToEpoch(startDate);
      filteredOrders = filteredOrders
          .where((trade) => trade.order.creationTime >= startTime)
          .toList();
    }

    if (endDate.isNotEmpty) {
      final int endTime = dateToEpoch(endDate);
      filteredOrders = filteredOrders
          .where((trade) => trade.order.creationTime <= endTime)
          .toList();
    }

    setState(() {
      _orders = filteredOrders;
    });
  }

  // Variables for pagination
  int _currentPage = 1;
  final int _rowsPerPage = 5;

  // Method to set the current page
  void _setCurrentPage(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate indices for pagination
    final int firstIndex = (_currentPage - 1) * _rowsPerPage;
    final int lastIndex = _currentPage * _rowsPerPage < _orders.length
        ? _currentPage * _rowsPerPage
        : _orders.length;
    final List<Trade> orders = _orders.sublist(firstIndex, lastIndex);

    return Container(
      height: ResponsiveWidget.isSmallScreen(context)
          ? MediaQuery.of(context).size.height * 0.65
          : 580,
      width: double.infinity,
      decoration: boxDecoration,
      child: Padding(
        padding:
            EdgeInsets.all(ResponsiveWidget.isSmallScreen(context) ? 14 : 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Text(
                  'Open Trades',
                  style: TextStyle(
                      fontSize: primaryFontSize,
                      color: primaryTextColor,
                      fontWeight: primaryFontWeight),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Filter(
                              symbols: _symbols, filterTable: _filterTable);
                        });
                  },
                  child: Container(
                      decoration: boxDecoration,
                      child: Padding(
                        padding: ResponsiveWidget.isSmallScreen(context)
                            ? const EdgeInsets.all(4)
                            : const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                        child: Row(
                          children: [
                            if (ResponsiveWidget.isLargeScreen(context)) ...[
                              const TextData(value: 'Filter'),
                              const SizedBox(
                                width: 8,
                              )
                            ],
                            const Icon(Icons.filter_list_rounded,
                                color: primaryTextColor, size: headingFontSize),
                          ],
                        ),
                      )),
                )
              ],
            ),
            ResponsiveWidget.isSmallScreen(context)
                ? lineDivider
                : const TableHeader(),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Expanded(
                child: Column(
                  children: [
                    for (final order in orders) ...[
                      order,
                      ResponsiveWidget.isSmallScreen(context)
                          ? lineDivider
                          : const SizedBox(
                              height: 8,
                            ),
                    ],
                  ],
                ),
              ),
            Row(
              children: [
                Text(
                  '${firstIndex + 1} - $lastIndex of ${_orders.length}',
                  style: const TextStyle(
                      fontSize: optionFontSize,
                      color: primaryTextColor,
                      fontWeight: secondaryFontWeight),
                ),
                const Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_currentPage > 1) {
                          _setCurrentPage(_currentPage - 1);
                        }
                      },
                      child: Container(
                        decoration: boxDecoration,
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(Icons.arrow_back_ios_rounded,
                              color: primaryTextColor, size: secondaryFontSize),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_currentPage < _orders.length ~/ _rowsPerPage) {
                          _setCurrentPage(_currentPage + 1);
                        }
                      },
                      child: Container(
                        decoration: boxDecoration,
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(Icons.arrow_forward_ios_rounded,
                              color: primaryTextColor, size: secondaryFontSize),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
