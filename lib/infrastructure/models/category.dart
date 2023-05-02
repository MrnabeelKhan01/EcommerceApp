
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));


class CategoryModel {
  CategoryModel({
     this.categoryName,
     this.categoryDescription,
     this.categoryImage,
     this.categoryId,
  });

  String ?categoryName;
  String ?categoryDescription;
  String ?categoryImage;
  String ?categoryId;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    categoryName: json["categoryName"],
    categoryDescription: json["categoryDescription"],
    categoryImage: json["categoryImage"],
    categoryId: json["categoryID"],
  );

  Map<String, dynamic> toJson(String categoryId) => {
    "categoryName": categoryName,
    "categoryDescription": categoryDescription,
    "categoryImage": categoryImage,
    "categoryID": categoryId,
  };
}
