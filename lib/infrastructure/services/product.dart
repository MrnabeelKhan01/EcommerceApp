import 'package:admin_app/infrastructure/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductServices {
  Future createProduct(ProductModel productModel) async {
    DocumentReference df =
        FirebaseFirestore.instance.collection("productCollection").doc();
    return await df.set(productModel.toJson(df.id));
  }

  Future updateProduct(ProductModel productModel) async {
    return FirebaseFirestore.instance
        .collection("productCollection")
        .doc(productModel.productId)
        .update({
      "productName": productModel.productName,
      "productImage": productModel.productImage,
      "productDescription": productModel.productDescription,
      "productPrice": productModel.productPrice,
    });
  }

  Future deleteProduct(String productId) async {
    return FirebaseFirestore.instance
        .collection("productCollection")
        .doc(productId)
        .delete();
  }

  Stream<List<ProductModel>> streamAllProducts(String productId) {
    return FirebaseFirestore.instance
        .collection("productCollection")
        .snapshots()
        .map((list) =>
            list.docs.map((e) => ProductModel.fromJson(e.data()!)).toList());
  }
  Stream<List<ProductModel>> streamCategoriesProducts(String categoryId) {
    print(categoryId);
    return FirebaseFirestore.instance
        .collection("productCollection").where("categoryID",isEqualTo:categoryId)
        .snapshots()
        .map((list) =>
        list.docs.map((e) => ProductModel.fromJson(e.data()!)).toList());
  }
}
