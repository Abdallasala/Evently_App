import 'package:evently_app_c13_sun_7_pm/core/services/snack_bar_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FirebaseAuth_Email_Password {


  static Future<bool> create_Account(String emailAddress,String password)async{
    EasyLoading.show();
    try {

     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      SnackBarService.showSuccessMessage('The Account create sucess');
      return Future.value(true);


    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarService.showErrorMessage(e.message??'The password provided is too weak');
        return Future.value(false);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        SnackBarService.showErrorMessage(e.message??'The account already exists for that email');
        return Future.value(false);
        print('The account already exists for that email.');
      }
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
      print(e);
    }
  }
  static Future<bool> signin_with_email_and_password(String emailAddress,String password)async{
    EasyLoading.show();
    try {

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      SnackBarService.showSuccessMessage('you are login sucessfuly');
      return Future.value(true);


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarService.showErrorMessage(e.message??'No user found for that email');
        return Future.value(false);
        print('The password provided is too weak.');
      } else if (e.code == 'wrong-password') {
        SnackBarService.showErrorMessage(e.message??'Wrong password provided for that user');
        return Future.value(false);
        print('The account already exists for that email.');
      }
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
      print(e);
    }
  }

}