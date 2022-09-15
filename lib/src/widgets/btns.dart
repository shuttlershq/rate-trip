import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rate_trip/src/utils/colors.dart';

class AppButtonAction extends StatelessWidget {
  const AppButtonAction({
    Key? key,
    this.onPressed,
    this.btnColor,
    this.labelColor,
    required this.label,
    this.loading = false,
    this.isAmount = false,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final Color? btnColor;
  final Color? labelColor;
  final bool loading;
  final bool isAmount;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final effectiveBackgroundColor = enabled && !loading
        ? btnColor ?? const Color(0xFF20E682)
        : const Color(0xFFC7D1CC);

    return TextButton(
      onPressed: onPressed,
      child: loading
          ? const CupertinoActivityIndicator(
              color: Color(0xFF101211),
            )
          : Text(
              label,
              style: GoogleFonts.heebo(
                fontSize: 14,
                height: 24 / 14,
                fontWeight: FontWeight.w700,
                color: enabled ? labelColor ?? black : Colors.white,
              ),
            ),
      style: TextButton.styleFrom(
        primary: effectiveBackgroundColor,
        backgroundColor: effectiveBackgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
