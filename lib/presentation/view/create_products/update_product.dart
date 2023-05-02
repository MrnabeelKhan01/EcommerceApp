import 'dart:io';

import 'package:admin_app/applications/upload_file.dart';
import 'package:admin_app/infrastructure/models/product.dart';
import 'package:admin_app/infrastructure/services/product.dart';
import 'package:admin_app/presentation/elements/app_button.dart';
import 'package:admin_app/presentation/elements/app_textfield.dart';
import 'package:admin_app/presentation/elements/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProductView extends StatefulWidget {
  UpdateProductView({Key? key, required this.productModel}) : super(key: key);
  ProductModel productModel = ProductModel();

  @override
  State<UpdateProductView> createState() => _UpdateProductViewState();
}

class _UpdateProductViewState extends State<UpdateProductView> {
  final ProductServices _productServices = ProductServices();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _nameController =
        TextEditingController(text: widget.productModel.productName);
    _descriptionController = TextEditingController(
      text: widget.productModel.productDescription,
    );
    _priceController =TextEditingController(text:widget.productModel.productPrice.toString(),);
    super.initState();
  }

  File? _file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:CustomText(text:"Update Product",color:Colors.black,),centerTitle:true,
        backgroundColor:Colors.transparent,
        elevation:0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                const SizedBox(height:24,),
               _file == null? Image.network(widget.productModel.productImage.toString()):Image.file(_file!),
                ElevatedButton(onPressed: (){
                  pickImage();
                }, child: Text("Pick Image")),

                const SizedBox(height:24,),
                AppTextField(
                    text: "Update Name",
                    keyBoardType: TextInputType.text,
                    controller: _nameController),
                const SizedBox(
                  height: 18,
                ),
                AppTextField(
                    text: "Update Descriptions",
                    keyBoardType: TextInputType.text,
                    controller: _descriptionController),
                const SizedBox(
                  height: 18,
                ),
                AppTextField(
                    text: "Update Price",
                    keyBoardType: TextInputType.number,
                    controller: _priceController),
                const SizedBox(
                  height: 18,
                ),
                AppButton(onPressed: ()async{
                  await UploadFileServices().getUrl(context, file: _file).then((value)async{
                    await _productServices.updateProduct(ProductModel(
                        productName:_nameController.text,
                        productDescription:_descriptionController.text,
                        productId:widget.productModel.productId,
                        productImage: value == ""?widget.productModel.productImage.toString() : value,
                        productPrice:int.parse(_priceController.text,
                        )
                    )).then((value){
                      Navigator.pop(context);
                    });
                  });

                }, btnLabel:"Update Product")
              ],
            ),
          ),
        ),
      ),
    );



  }


  final ImagePicker _picker = ImagePicker();

  Future pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final temporaryImage = File(image!.path);
    setState(() {
      _file = temporaryImage;
    });
  }
}
