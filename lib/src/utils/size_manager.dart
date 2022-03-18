import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeMg {
  static double get screenWidth => 1.sw;
  static double get screenHeight => 1.sh;
  static double height(double height) => height.h;
  static double width(double width) => width.w;
  static double text(double size) => size.sp;
  static double radius(double size) => size.r;
  static double padH(double size) => width(size);
  static double padV(double size) => height(size);
}
