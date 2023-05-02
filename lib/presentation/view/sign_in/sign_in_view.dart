import 'package:admin_app/presentation/view/sign_in/layout/body.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:SignInBody(),
    );
  }
}
