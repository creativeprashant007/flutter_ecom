import 'dart:ui';

class ColorHelper {
  static Color getColor(String colorCode) {
    if (colorCode.toLowerCase() == "comment") {
      return const Color(0xFF000000); // Black color for "comment"
    }
    return Color(int.parse('0xFF$colorCode'));
  }
}
