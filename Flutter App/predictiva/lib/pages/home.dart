import 'package:flutter/material.dart';
import 'package:predictiva/constants/constants.dart';
import 'package:predictiva/widgets/summary.dart';
import 'package:predictiva/widgets/trades.dart';


// Define a stateless widget named 'Home'
class Home extends StatelessWidget {
  // Constructor for the Home widget, using a constant constructor
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi Robin,',
                    style: TextStyle(
                        fontSize: headingFontSize,
                        color: primaryTextColor,
                        fontWeight: primaryFontWeight)),
                Text('Here is an overview of your account activities.',
                    style: TextStyle(
                        fontWeight: secondaryFontWeight,
                        fontSize: secondaryFontSize,
                        color: primaryTextColor)),
                SizedBox(
                  height: 20,
                ),
                Summary(),
                SizedBox(
                  height: 20,
                ),
                Trades()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
