import 'package:bigwelt_task/core/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/failure.dart';
import '../../../core/type_def.dart';
import '../model/user_model.dart';

class AuthController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firestoreAuth = FirebaseAuth.instance;
  ///Login with userName and Password
  FutureEither<UserModel>loginWithUserNameAndPassword({required String password,required String name,}) async {
   try{
     QuerySnapshot snapshot=await _firestore.collection(FirebaseConstants.userCollections).where("password",isEqualTo: password,).where("name",isEqualTo: name).get();
     if(snapshot.docs.isNotEmpty){
       DocumentSnapshot snap = snapshot.docs.first;
       UserModel user = UserModel.fromMap(snap.data() as Map<String, dynamic>);
         return right(user);
     }
     else {
       return throw "Invalid User name Password";
     }
   }
   on FirebaseException catch( em ){
     throw em.message!;
   }
   catch (e){
     return left(Failure(e.toString()));
   }
  }

  ///google signing
  FutureEither<UserModel>googleSign() async {
    UserModel? userModel;
   try{
     final GoogleSignInAccount? googleUser =  await GoogleSignIn().signIn();
     if (googleUser == null) {
       return left(Failure('Sign in aborted by user'));
     }
     final googleAuth = await googleUser.authentication;
     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken,
     );
     print("ssssssssssssss");
     final userCredential = await  FirebaseAuth.instance.signInWithCredential(credential);

       userModel=UserModel(name: googleUser.displayName!,
           id:  userCredential.user!.uid,
           profile: googleUser.photoUrl??"",
           password: "",
           phoneNumber:"",
           email: googleUser.email);
       await _firestore.collection(FirebaseConstants.userCollections).doc(userCredential.user!.uid).set(userModel.toMap());
     return right(userModel);
   }
   on FirebaseException catch( em ){
     print(em.message);
     throw em.message!;
   }
   catch (e){
     print(e.toString());
     return left(Failure(e.toString()));
   }
  }

  /// forgot password
  FutureVoid forgotPassword(String name,String password) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(
          FirebaseConstants.userCollections)
          .where("name", isEqualTo: name)
          .get();
      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot snap = snapshot.docs.first;
        UserModel user = UserModel.fromMap(snap.data() as Map<String, dynamic>);
        UserModel userModel=user.copyWith(password: password);
        return right(await _firestore.collection(
            FirebaseConstants.userCollections).doc(user.id).update(userModel.toMap()));
      }
      else {
        return throw "Invalid User name";
      }
    } on FirebaseException catch (em) {
      return throw em.message!;
    }
    catch (e) {
      print('Error: $e');
      return left(Failure(e.toString()));
    }
  }
}