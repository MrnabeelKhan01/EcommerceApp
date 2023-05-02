import 'package:admin_app/infrastructure/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CategoryServices {
  Future createCategory(CategoryModel categoryModel) async {
    DocumentReference df =
        FirebaseFirestore.instance.collection("categoryCollection").doc();
    return await df.set(categoryModel.toJson(df.id));
  }

  Future updateCategory(CategoryModel categoryModel) async {
    return FirebaseFirestore.instance
        .collection("categoryCollection")
        .doc(categoryModel.categoryId)
        .update({
      "categoryName": categoryModel.categoryName,
      "categoryImage": categoryModel.categoryImage,
      "categoryDescription": categoryModel.categoryDescription
    });
  }

  Future deleteCategory(String docId) async {
    return FirebaseFirestore.instance
        .collection("categoryCollection")
        .doc(docId)
        .delete();
  }

  Future<List<CategoryModel>> fetchCategory(BuildContext context) {
    return FirebaseFirestore.instance
        .collection("categoryCollection")
        .get()
        .then((event) =>
            event.docs.map((e) => CategoryModel.fromJson(e.data()!)).toList());
  }

  //fetch all categories
  Stream<List<CategoryModel>> fetchAllCategories(String categoryId) {
    return FirebaseFirestore.instance
        .collection("categoryCollection")
        .snapshots()
        .map((list) =>
            list.docs.map((e) => CategoryModel.fromJson(e.data()!)).toList());
  }
}
