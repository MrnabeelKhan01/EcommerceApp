import 'package:admin_app/infrastructure/models/product.dart';
import 'package:admin_app/presentation/elements/custom_text.dart';
import 'package:flutter/material.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({Key? key, required this.productModel}) : super(key: key);
  ProductModel productModel = ProductModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: CustomText(
          text: "Product Details",
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                Image.network(productModel.productImage.toString()),
                const SizedBox(
                  height: 18,
                ),
                CustomText(text: "Name:${productModel.productName}"),
                CustomText(text: productModel.productDescription.toString()),
                CustomText(text: productModel.productPrice.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
