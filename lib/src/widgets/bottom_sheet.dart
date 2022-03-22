import 'package:flutter/material.dart';

class CustomBottomSheet {
  static showBottomSheet(BuildContext context, Widget displayWidget,
      {double heightfactor = 0.862}) {
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: heightfactor,
              child: SingleChildScrollView(child: displayWidget));
        });
  }
}
