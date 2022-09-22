class ListItem {
  late String itemId;
  late String listId;
  late bool toBuy;
  String category = "";

  ListItem(
      {required this.itemId,
      required this.listId,
      required this.toBuy,
      required this.category});

  ListItem.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    listId = json['list_id'];
    toBuy = json['to_buy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['list_id'] = listId;
    data['to_buy'] = toBuy;
    return data;
  }
}
