import 'package:flutter/material.dart';
import 'package:tea/utils/constants/size.dart';

class ChipWidget extends StatelessWidget {
  final String label;
  final Color color;
  const ChipWidget(this.label, {this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: EdgeInsets.all(CentralSize.labelPadding),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color ?? Colors.red,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(CentralSize.generalPadding),
    );
  }
}
