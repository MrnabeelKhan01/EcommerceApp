import 'package:admin_app/infrastructure/models/category.dart';
import 'package:admin_app/infrastructure/models/product.dart';
import 'package:admin_app/infrastructure/services/category.dart';
import 'package:admin_app/infrastructure/services/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../elements/custom_text.dart';

class CategoryView extends StatelessWidget {
  final String categoryID;
  final String categoryName;
  CategoryView({Key? key, required this.categoryID, required this.categoryName}) : super(key: key);
  final ProductServices _productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.transparent,
        elevation:0,
        title:CustomText(text:categoryName,color:Colors.black,),
        centerTitle:true,
        leading:  IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          StreamProvider.value(
            value: _productServices
                .streamCategoriesProducts(categoryID.toString()),
            initialData: [ProductModel()],
            builder: (context, snapshots) {
              List<ProductModel> productList =
                  context.watch<List<ProductModel>>();
              return ListView.builder(
                  itemCount: productList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 140,
                                      child: Image.network(productList[i]
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                          ],
                        ),
                      ),
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}
