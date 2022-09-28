import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:shopping_list/model/ListItem.dart';
import 'package:shopping_list/utils/color_utils.dart';

Column categoryView(String category) {
  if (global.myList.where((element) => element.category == category).isEmpty) {
    return Column(); //if theres no items for this category
  } else {
    //if category does have items
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 25), //add space
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
        //add space
        height: 10,
      ),
      for (ListItem entry in global.myList)
        if (entry.category == category)
          Row(
            mainAxisAlignment: MainAxisAlignment.start, //middle
            children: [
              const SizedBox(width: 15),
              Checkbox(
                  //to mark if item is bought or not
                  checkColor: Colors.white, //tick in circle
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return myColors("Purple"); //colour when filled
                  }),
                  value: !entry.toBuy, //change to opposite
                  shape: const CircleBorder(), //shape
                  onChanged: (bool? value) {
                    //when clicked change value
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
        //add space
        height: 20,
      ) //Text(item)
    ]);
  }
}
