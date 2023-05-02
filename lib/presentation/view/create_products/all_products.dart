import 'package:admin_app/infrastructure/models/product.dart';
import 'package:admin_app/infrastructure/services/product.dart';
import 'package:admin_app/presentation/elements/custom_text.dart';
import 'package:admin_app/presentation/view/create_products/product_details_view.dart';
import 'package:admin_app/presentation/view/create_products/update_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  ProductView({Key? key}) : super(key: key);
  final ProductServices _productServices = ProductServices();
  ProductModel productModel = ProductModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          text: "All Products",
          color: Colors.black,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 34,
                ),
                StreamProvider.value(
                  value: _productServices
                      .streamAllProducts(productModel.productId.toString()),
                  initialData: [ProductModel()],
                  builder: (context, snapshots) {
                    List<ProductModel> productList =
                        context.watch<List<ProductModel>>();
                    return ListView.builder(
                        itemCount: productList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetailsView(
                                          productModel: productList[i])));
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: 140,
                                              child: Image.network(
                                                  productList[i]
                                                      .productImage
                                                      .toString()),
                                            ),
                                            CustomText(
                                                text: productList[i]
                                                    .productName
                                                    .toString()),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 120,
                                              child: CustomText(
                                                text: productList[i]
                                                    .productDescription
                                                    .toString(),
                                              ),
                                            ),
                                            CustomText(
                                                text: productList[i]
                                                    .productPrice
                                                    .toString()),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              _productServices.deleteProduct(
                                                  productList[i]
                                                      .productId
                                                      .toString());
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateProductView(
                                                              productModel:
                                                                  productList[
                                                                      i])));
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.black,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
