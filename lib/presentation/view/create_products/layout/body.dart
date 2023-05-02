import 'dart:io';
import 'package:admin_app/applications/upload_file.dart';
import 'package:admin_app/infrastructure/models/product.dart';
import 'package:admin_app/infrastructure/services/product.dart';
import 'package:admin_app/presentation/elements/app_button.dart';
import 'package:admin_app/presentation/elements/app_textfield.dart';
import 'package:admin_app/presentation/view/create_products/all_products.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../infrastructure/models/category.dart';
import '../../../../infrastructure/services/category.dart';

class CreateProductBody extends StatefulWidget {
  const CreateProductBody({Key? key}) : super(key: key);

  @override
  State<CreateProductBody> createState() => _CreateProductBodyState();
}

class _CreateProductBodyState extends State<CreateProductBody> {
  final TextEditingController _productName = TextEditingController();

  final TextEditingController _productDescription = TextEditingController();

  final TextEditingController _productPrice = TextEditingController();
  final ProductServices _productServices = ProductServices();
  ProductModel productModel = ProductModel();
  final List<CategoryModel> _categoriesList = [];

  @override
  void initState() {
    // TODO: implement initState
    CategoryServices().fetchCategory(context).then((value) {
      _categoriesList.addAll(value);
      setState(() {});
    });
    super.initState();
  }

  CategoryModel? categoryModel;
  File? myImage;

  final ImagePicker _picker = ImagePicker();

  Future pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final temporaryImage = File(image!.path);
    setState(() {
      myImage = temporaryImage;
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: isLoading
            ? const SizedBox(
                height: 35,
                width: 35,
                child: CircularProgressIndicator(
                  color: Colors.black,
                ))
            : SingleChildScrollView(
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _getCategoryDropDown(),
                      ],
                    ),
                    const SizedBox(
                      height: 34,
                    ),
                    InkWell(
                      onTap: () {
                        pickImage();
                      },
                      child: myImage != null
                          ? SizedBox(height: 280, child: Image.file(myImage!))
                          : SizedBox(
                              height: 280,
                              width: MediaQuery.of(context).size.width,
                              child: const Icon(
                                Icons.image,
                                size: 100,
                                color: Colors.black26,
                              )),
                    ),
                    const SizedBox(
                      height: 34,
                    ),
                    AppTextField(
                        text: "Product Name",
                        keyBoardType: TextInputType.text,
                        controller: _productName),
                    const SizedBox(
                      height: 18,
                    ),
                    AppTextField(
                        text: "Product Description",
                        keyBoardType: TextInputType.text,
                        controller: _productDescription),
                    const SizedBox(
                      height: 18,
                    ),
                    AppTextField(
                        text: "Product Price",
                        keyBoardType: TextInputType.text,
                        controller: _productPrice),
                    const SizedBox(
                      height: 44,
                    ),
                    AppButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          UploadFileServices()
                              .getUrl(context, file: myImage!)
                              .then((value) {
                            _productServices.createProduct(ProductModel(
                                productImage: value,
                                productName: _productName.text,
                                productDescription: _productDescription.text,
                                productPrice: int.parse(_productPrice.text),
                                categoryId:
                                    categoryModel!.categoryId.toString()));
                          }).then((value) {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductView()));
                          });
                        },
                        btnLabel: "Add Product")
                  ],
                ),
            ),
      ),
    );
  }

  _getCategoryDropDown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
            child: DropdownButton(
              underline: const SizedBox(),
              hint: const Text(
                'Categories',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
              value: categoryModel,
              iconEnabledColor: const Color(0xff7B7777),
              iconDisabledColor: const Color(0xff7B7777),
              onChanged: (newValue) {
                setState(() {
                  categoryModel = newValue as CategoryModel;
                });
              },
              items: _categoriesList.map((valueItem) {
                return DropdownMenuItem(
                    value: valueItem,
                    child: Text((valueItem.categoryName.toString())));
              }).toList(),
            ),
          )),
    );
  }
}
