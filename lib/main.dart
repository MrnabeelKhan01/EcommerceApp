import 'package:admin_app/presentation/view/create_category/create_category_view.dart';
import 'package:admin_app/presentation/view/sign_in/sign_in_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'applications/wrapper.dart';
import 'presentation/view/create_category/all_categories.dart';
import 'presentation/view/create_products/all_products.dart';
import 'presentation/view/create_products/create_product_view.dart';


void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily:"Poppins"
      ),
      home:  ProductView(),
    );
  }
}

