class FamilyModel {
  String? full_name;

  FamilyModel({this.full_name});

  // receiving data from server
  factory FamilyModel.fromMap(map) {
    return FamilyModel(full_name: map['full_name']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {'full_name': full_name};
  }
}
