import 'package:admin_app/infrastructure/models/category.dart';
import 'package:admin_app/infrastructure/models/product.dart';
import 'package:admin_app/infrastructure/services/category.dart';
import 'package:admin_app/presentation/elements/custom_text.dart';
import 'package:admin_app/presentation/view/create_category/category_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCategories extends StatelessWidget {
  AllCategories({Key? key}) : super(key: key);
  final CategoryServices _categoryServices = CategoryServices();
  CategoryModel categoryModel = CategoryModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          text: "All Categories",
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StreamProvider.value(
            value: _categoryServices
                .fetchAllCategories(categoryModel.categoryId.toString()),
            initialData: [CategoryModel()],
            builder: (context, child) {
              List<CategoryModel> categoryList =
                  context.watch<List<CategoryModel>>();
              return GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 2.2 / 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: categoryList.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryView(
                                      categoryID:
                                          categoryList[i].categoryId.toString(),
                                      categoryName: categoryList[i].categoryName.toString(),
                                    )));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: Image.network(
                                    categoryList[i].categoryImage.toString()),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomText(
                                  text:
                                      categoryList[i].categoryName.toString()),
                              CustomText(
                                  text: categoryList[i]
                                      .categoryDescription
                                      .toString())
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
    );
  }
}
