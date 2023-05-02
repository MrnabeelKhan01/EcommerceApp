
import 'package:admin_app/infrastructure/services/auth.dart';
import 'package:admin_app/presentation/view/create_products/create_product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../configurations/frontend_configs.dart';
import '../../../elements/app_button.dart';
import '../../../elements/auth_field.dart';
import '../../bottom_navbar.dart';
import '../../../elements/custom_text.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
   final AuthServices _authServices =AuthServices();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? const Center(
              child: SizedBox(
                  height: 45, width: 45, child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 34,
                    ),
                    CustomText(
                      text: 'Login to Continue',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomTextField(
                        icon: Icons.email_outlined,
                        text: "Email",
                        controller: _emailController,
                        onTap: () {},
                        keyBoardType: TextInputType.emailAddress),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomTextField(
                        isPassword: true,
                        isSecure: true,
                        controller: _passwordController,
                        icon: Icons.lock_outline_sharp,
                        text: "Password",
                        onTap: () {},
                        keyBoardType: TextInputType.emailAddress),
                    Transform.translate(
                      offset: const Offset(6, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 35,
                            child: TextButton(
                              onPressed: () {
                                // _authServices.resetPassword(_emailController.text);
                              },
                              child: CustomText(
                                text: 'Forgot Password?',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppButton(onPressed: (){
                      setState(() {
                        isLoading=true;
                      });
                      if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
                        _authServices.signIn(email: _emailController.text, password:_passwordController.text).then((value){
                          setState(() {
                            isLoading=false;
                          });
                          print("Working");
                        }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateProductView())));
                      }else{
                        print("Please enter password and email");
                      }
                    }, btnLabel:"Sign In"),
                    const SizedBox(
                      height: 34,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: FrontendConfigs.kAuthIconColor,
                        )),
                        const SizedBox(
                          width: 12,
                        ),
                        CustomText(
                          text: "Or continue with",
                          fontSize: 16,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: Divider(
                          color: FrontendConfigs.kAuthIconColor,
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
