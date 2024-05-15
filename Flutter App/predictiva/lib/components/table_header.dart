import 'package:flutter/material.dart';
import 'package:predictiva/components/text_data.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: TextData(value: 'Symbol'),
          ),
          Expanded(
            child: TextData(value: 'Price'),
          ),
          Expanded(
            child: TextData(value: 'Type'),
          ),
          Expanded(
            child: TextData(value: 'Action'),
          ),
          Expanded(
            child: TextData(value: 'Quantity'),
          ),
          Expanded(
            child: TextData(value: 'Date'),
          ),
        ],
      ),
    );
  }
}
