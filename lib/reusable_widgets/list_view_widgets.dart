import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:shopping_list/model/ListItem.dart';
import 'package:shopping_list/utils/color_utils.dart';

Column categoryView(String category) {
  if (global.myList.where((element) => element.category == category).isEmpty) {
    return Column();
  } else {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 25),
          Text(
              category[0].toUpperCase() +
                  category.substring(1), //make first letter capital
              style: TextStyle(
                  color: myColors("Blue"),
                  fontWeight: FontWeight.w500,
                  fontSize: 18)),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      for (ListItem entry in global.myList)
        if (entry.category == category)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 15),
              Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return myColors("Purple");
                  }),
                  value: !entry.toBuy,
                  shape: const CircleBorder(),
                  onChanged: (bool? value) {
                    //(bool? value) {
                    //setState(() {
                    value = true;
                  }),
              Text(
                  entry.itemId[0].toUpperCase() +
                      entry.itemId.substring(1), //make first etter capital
                  style: TextStyle(
                      color: myColors("Grey"),
                      fontSize: 16,
                      fontWeight: FontWeight.normal))
            ],
          ),
      const SizedBox(
        height: 20,
      ) //Text(item)
    ]);
  }
}

void doNothing() {}
