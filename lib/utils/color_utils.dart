import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }
  return Color(int.parse(hexColor, radix: 16));
}

myColors(String Colour) {
  if (Colour == "Grey") {
    return Color.fromARGB(255, 174, 174, 175);
  } else if (Colour == "FiftyGrey") {
    return Color.fromARGB(125, 174, 174, 175);
  } else if (Colour == "EightyWhite") {
    return Color.fromARGB(204, 255, 255, 255);
  } else if (Colour == "Purple") {
    return Color.fromARGB(255, 139, 106, 255);
  } else if (Colour == "White") {
    return Color.fromARGB(255, 255, 255, 255);
  } else if (Colour == "Red") {
    return Color.fromARGB(255, 249, 129, 129);
  }
}
