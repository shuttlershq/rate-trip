import 'package:flutter/material.dart';

class CustomBottomSheet {
  static showBottomSheet(BuildContext context, Widget displayWidget,
      {double heightfactor = 0.862}) {
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        // useRootNavigator: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        context: context,
        builder: (context) {
          return SingleChildScrollView(child: displayWidget);
        });
  }
}

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 48,
        height: 4,
        margin: const EdgeInsets.only(top: 8),
        decoration: const BoxDecoration(
          color: Color(0xFFEFF2F7),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }
}
