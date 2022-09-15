import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class Catagories {
  late String name;
  late SvgPicture pic;

  Catagories({
    required this.name,
    required this.pic,
  });
}

final allCatagories = [
  Catagories(name: "Bakery", pic: SvgPicture.asset('assets/icons/Bakery.svg')),
  Catagories(
      name: "Beverages", pic: SvgPicture.asset('assets/icons/Beverages.svg')),
  Catagories(name: "Canned", pic: SvgPicture.asset('assets/icons/Canned.svg')),
];
