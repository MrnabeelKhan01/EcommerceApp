import 'package:admin_app/infrastructure/models/category.dart';
import 'package:admin_app/presentation/view/create_products/layout/body.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/services/category.dart';
import '../../elements/custom_text.dart';

class CreateProductView extends StatefulWidget {
   const CreateProductView({Key? key}) : super(key: key);

  @override
  State<CreateProductView> createState() => _CreateProductViewState();
}

class _CreateProductViewState extends State<CreateProductView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.transparent,
        elevation:0,
      ),
      body:const CreateProductBody(),
    );
  }

}
