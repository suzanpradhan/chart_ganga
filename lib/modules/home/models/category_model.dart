class CategoryModel {
  final int? id;
  final String? name;

  CategoryModel({this.id, this.name});

  factory CategoryModel.fromJson({required Map<String, dynamic> map}) {
    return CategoryModel(id: map["id"], name: map["title"]);
  }
}
