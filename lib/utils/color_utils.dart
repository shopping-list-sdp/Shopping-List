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
    return const Color.fromARGB(255, 174, 174, 175);
  } else if (Colour == "FiftyGrey") {
    return const Color.fromARGB(125, 174, 174, 175);
  } else if (Colour == "EightyWhite") {
    return const Color.fromARGB(204, 255, 255, 255);
  } else if (Colour == "Purple") {
    return const Color.fromARGB(255, 139, 106, 255);
  } else if (Colour == "FiftyPurple") {
    return const Color.fromARGB(125, 139, 106, 255);
  } else if (Colour == "White") {
    return const Color.fromARGB(255, 255, 255, 255);
  } else if (Colour == "Red") {
    return const Color.fromARGB(255, 249, 129, 129);
  } else if (Colour == "FiftyRed") {
    return const Color.fromARGB(125, 249, 129, 129);
  } else if (Colour == "TwentyGrey") {
    return const Color.fromARGB(51, 174, 174, 175);
  } else if (Colour == "TenGrey") {
    return const Color.fromARGB(255, 239, 239, 239);
  } else if (Colour == "Blue") {
    return const Color.fromARGB(255, 49, 219, 238);
  } else if (Colour == "FiftyBlue") {
    return const Color.fromARGB(125, 49, 219, 238);
  } else if (Colour == "Pink") {
    return const Color.fromARGB(255, 246, 165, 235);
  } else if (Colour == "Yellow") {
    return const Color.fromARGB(255, 255, 228, 126);
  } else if (Colour == "Green") {
    return const Color.fromARGB(255, 140, 235, 116);
  } else if (Colour == "FiftyGreen") {
    return const Color.fromARGB(125, 140, 235, 116);
  } else if (Colour == "FiftyYellow") {
    return const Color.fromARGB(204, 255, 228, 126);
  }
}
