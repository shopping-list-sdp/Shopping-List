class pantryItem {
  late String id; //id of the list item
  late String itemId; //item id
  late String pantryId;
  late int quantity; // list id of list item belongs to
  String category = ""; //category item belongs to

  pantryItem(
      //required to force these paras
      {required this.id,
      required this.itemId,
      required this.pantryId,
      required this.quantity,
      required this.category});

  pantryItem.fromJson(Map<String, dynamic> json) {
    //to get item from db
    id = json['id'];
    itemId = json['item_id'];
    pantryId = json['pantry_id'];
    quantity = json['quantity'];
  }

  bool Contains(String value) {
    if (itemId.contains(value)) {
      return true;
    } else {
      return false;
    }
  }
}
