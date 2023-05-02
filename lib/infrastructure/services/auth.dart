import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  Future signIn({required String email,required String password})async{
    return FirebaseAuth.instance.
    signInWithEmailAndPassword(email: email, password: password);
  }
  Future logOut()async{
    return await FirebaseAuth.instance.signOut();
  }
}