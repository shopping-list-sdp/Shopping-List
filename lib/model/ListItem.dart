class ListItem {
  late String id; //id of the list item
  late String itemId; //item id
  late String listId; // list id of list item belongs to
  late bool toBuy; //false when item has not been marked off list
  String category = ""; //category item belongs to

  ListItem(
      //required to force these paras
      {required this.id,
      required this.itemId,
      required this.listId,
      required this.toBuy,
      required this.category});

  ListItem.fromJson(Map<String, dynamic> json) {
    //to get item from db
    id = json['id'];
    itemId = json['item_id'];
    listId = json['list_id'];
    toBuy = json['to_buy'];
  }

  Map<String, dynamic> toJson() {
    //to post item to db
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_id'] = itemId;
    data['list_id'] = listId;
    data['to_buy'] = toBuy;
    return data;
  }
}
