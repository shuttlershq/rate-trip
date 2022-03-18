import 'package:flutter/material.dart';

class CustomBottomSheet {
  static showBottomSheet(BuildContext context, Widget displayWidget) {
    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.862,
              child: SingleChildScrollView(child: displayWidget));
        });
  }
}
