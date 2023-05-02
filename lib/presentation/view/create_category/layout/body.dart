import 'dart:io';
import 'package:admin_app/applications/upload_file.dart';
import 'package:admin_app/infrastructure/models/category.dart';
import 'package:admin_app/infrastructure/models/product.dart';
import 'package:admin_app/infrastructure/services/category.dart';
import 'package:admin_app/infrastructure/services/product.dart';
import 'package:admin_app/presentation/elements/app_button.dart';
import 'package:admin_app/presentation/elements/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

class CreateCategoryBody extends StatefulWidget {
  const CreateCategoryBody({Key? key}) : super(key: key);

  @override
  State<CreateCategoryBody> createState() => _CreateCategoryBodyState();
}

class _CreateCategoryBodyState extends State<CreateCategoryBody> {
  final TextEditingController _categoryName = TextEditingController();

  final TextEditingController _categoryDescription = TextEditingController();
  final CategoryServices _categoryServices = CategoryServices();
  File? myImage;

  final ImagePicker _picker = ImagePicker();

  Future pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final temporaryImage = File(image!.path);
    setState(() {
      myImage = temporaryImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const SizedBox(
                height: 34,
              ),
              InkWell(
                onTap: () {
                  pickImage();
                },
                child: myImage != null
                    ? Image.file(myImage!)
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
                height: 18,
              ),
              AppTextField(
                  text: "Category Name",
                  keyBoardType: TextInputType.text,
                  controller: _categoryName),
              const SizedBox(
                height: 18,
              ),
              AppTextField(
                  text: "Category Description",
                  keyBoardType: TextInputType.text,
                  controller: _categoryDescription),
              const SizedBox(
                height: 18,
              ),
              AppButton(
                  onPressed: () {
                    UploadFileServices()
                        .getUrl(context, file: myImage!)
                        .then((value) {
                      _categoryServices.createCategory(CategoryModel(
                          categoryName: _categoryName.text,
                          categoryDescription: _categoryDescription.text,
                          categoryImage: value));
                    });
                  },
                  btnLabel: "Add Category")
            ],
          ),
        ),
      ),
    );
  }
}
