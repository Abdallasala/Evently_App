import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/firebase_firestore_serivce.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/snack_bar_service.dart';
import 'package:evently_app_c13_sun_7_pm/models/event_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Firebase_funcation {
   static final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '767982188698-iiid07frphp11ahkd350efeptr14bs2l.apps.googleusercontent.com',
  );

  static Future<bool> create_Account(String emailAddress, String password) async {
    EasyLoading.show();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      SnackBarService.showSuccessMessage('The Account created successfully');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarService.showErrorMessage(e.message ?? 'The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        SnackBarService.showErrorMessage(e.message ?? 'The account already exists for that email');
      } else {
        SnackBarService.showErrorMessage(e.message ?? 'Failed to create account');
      }
      return false;
    } catch (e) {
      SnackBarService.showErrorMessage('An error occurred');
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<bool> signin_with_email_and_password(String emailAddress, String password) async {
    EasyLoading.show();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      SnackBarService.showSuccessMessage('Logged in successfully');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarService.showErrorMessage(e.message ?? 'No user found for that email');
      } else if (e.code == 'wrong-password') {
        SnackBarService.showErrorMessage(e.message ?? 'Wrong password provided');
      } else {
        SnackBarService.showErrorMessage(e.message ?? 'Failed to sign in');
      }
      return false;
    } catch (e) {
      SnackBarService.showErrorMessage('An error occurred');
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      EasyLoading.show();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign in
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e, stackTrace) {
      print("GOOGLE SIGN IN ERROR: $e");
      print(stackTrace);
      SnackBarService.showErrorMessage("Google Sign In failed: $e");
      return null;
    } finally {
      EasyLoading.dismiss();
    }
  }
  static Future<void> resetPassword(String email) async{
  try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    SnackBarService.showSuccessMessage('Reset password successfully');
    //Future.value(true);

  }catch(e){
    Future.value(false);
    SnackBarService.showErrorMessage('faild reset password ');
  }
  }
static CollectionReference<EventDataModel> getCollectionRef(){
    ///Get instance from firestore using func with converter to
  return  FirebaseFirestore.instance.collection(EventDataModel.collectionName).withConverter(
        fromFirestore: (snapshot,_)=>EventDataModel.fromFirestore(snapshot.data()!),
        toFirestore: (event,_)=>event.toFirestore());
  }
static Future<void>  createNewEvent(EventDataModel eventData)async{
   final  collectionRef =getCollectionRef();
 var docRef=   collectionRef.doc();
   eventData.eventID =docRef.id;
  return await docRef.set(eventData);
  }
}
