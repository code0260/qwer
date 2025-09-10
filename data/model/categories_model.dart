class CategoriesModel {
  int? categoriesId;
  String? categoriesName;
  String? categoriesDateTime;

  CategoriesModel(
      {this.categoriesId, this.categoriesName, this.categoriesDateTime});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    categoriesId = json['categories_id'];
    categoriesName = json['categories_name'];
    categoriesDateTime = json['categories_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categories_id'] = categoriesId;
    data['categories_name'] = categoriesName;
    data['categories_datetime'] = categoriesDateTime;
    return data;
  }
}
