import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:shopping_list/utils/color_utils.dart';

void myListView() {
  print(global.myListItemCategory);
}

Column categoryView(String category) {
  if (!global.myListItemCategory.containsValue(category)) {
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
      for (MapEntry<String, String> entry in global.myListItemCategory.entries)
        if (entry.value == category)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 15),
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return myColors("Purple");
                  }
                  return myColors("FiftyPurple");
                }),
                value: false,
                shape: const CircleBorder(),
                onChanged: (value) {}, //(bool? value) {
                //setState(() {
                //isChecked = value!;
                //}
              ),
              Text(
                  entry.key[0].toUpperCase() +
                      entry.key.substring(1), //make first etter capital
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
