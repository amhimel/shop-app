import 'package:shop_app/views/shared/export_packages.dart';

TextStyle appstyle(double fontSize, FontWeight fontWeight, Color color) {
  return GoogleFonts.poppins(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
  );
}

TextStyle appstyleWithHT(
  double fontSize,
  FontWeight fontWeight,
  Color color,
  double height,
) {
  return GoogleFonts.poppins(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: height,
  );
}
