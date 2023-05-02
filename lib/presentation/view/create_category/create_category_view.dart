import 'package:admin_app/presentation/elements/custom_text.dart';
import 'package:admin_app/presentation/view/create_category/layout/body.dart';
import 'package:flutter/material.dart';

class CreateCategoryView extends StatefulWidget {
  const CreateCategoryView({Key? key}) : super(key: key);

  @override
  State<CreateCategoryView> createState() => _CreateCategoryViewState();
}

class _CreateCategoryViewState extends State<CreateCategoryView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.transparent,
        elevation:0,
        centerTitle:true,
        title:CustomText(text: 'Create Category',color:Colors.black,),
      ),
      body:const CreateCategoryBody(),
    );
  }
}
