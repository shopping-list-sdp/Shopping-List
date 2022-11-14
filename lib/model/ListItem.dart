class ListItem {
  late String id; //id of the list item
  late String itemId; //item id
  late String listId; // list id of list item belongs to
  late bool toBuy; //false when item has not been marked off list
  String category = ""; //category item belongs to
  late String price;
  late int quantity;

  ListItem(
      //required to force these paras
      {required this.id,
      required this.itemId,
      required this.listId,
      required this.toBuy,
      required this.category,
      required this.price,
      required this.quantity});

  ListItem.fromJson(Map<String, dynamic> json) {
    //to get item from db
    id = json['id'];
    itemId = json['item_id'];
    listId = json['list_id'];
    toBuy = json['to_buy'];
    price = json['price'];
    quantity = json['quantity'];
  }
}
