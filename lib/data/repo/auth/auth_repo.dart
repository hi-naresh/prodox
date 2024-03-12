import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prodox/routes.dart';
import 'package:prodox/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:prodox/utils/exceptions/firebase_exceptions.dart';
import 'package:prodox/utils/exceptions/format_exceptions.dart';
import 'package:prodox/utils/exceptions/platform_exceptions.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  //get authenticaed user
  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    super.onReady();
    screenRedirect();
  }

  screenRedirect() => Future.delayed(const Duration(seconds: 2), () {
    final user = _auth.currentUser;
    // deviceStorage.read('isLogged') == true
    //     ? Get.offAllNamed(PRoutes.getMasterRoute())
    //     : Get.offAllNamed(PRoutes.getOnBoardingRoute());
    if (user !=null){
      Get.offAllNamed(PRoutes.getMasterRoute());
    }else {
      deviceStorage.writeIfNull('isLogged', false);
      Get.offAllNamed(PRoutes.getOnBoardingRoute());
    }
  });

  //register user
  Future<UserCredential> registerUser(String email, String password) async {
    try{
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      throw PFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw PFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const PFormatException();
    } on PlatformException catch(e){
      throw PPlatformException(e.code).message;
    } catch (e){
      throw 'Something went Wrong. Try Again';
    }
  }

  //login user
  Future<UserCredential> loginUser(String email, String password) async {
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      throw PFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw PFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const PFormatException();
    } on PlatformException catch(e){
      throw PPlatformException(e.code).message;
    } catch (e){
      throw 'Something went Wrong. Try Again';
    }
  }

  //google sign in
  Future<UserCredential> signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await _auth.signInWithCredential(credentials);

    } on FirebaseAuthException catch(e){
      throw PFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw PFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const PFormatException();
    } on PlatformException catch(e){
      throw PPlatformException(e.code).message;
    } catch (e){
      throw 'Something went Wrong. Try Again';
    }
  }

  //resetPassword user
  Future<void> resetPassword(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch(e){
      throw PFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw PFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const PFormatException();
    } on PlatformException catch(e){
      throw PPlatformException(e.code).message;
    } catch (e){
      throw 'Something went Wrong. Try Again';
    }
  }
  //logout user
  Future<void> logoutUser() async {
    try{
      await GoogleSignIn().signOut();
      await _auth.signOut();
      deviceStorage.write('isLogged', false);
      Get.offAllNamed(PRoutes.getOnBoardingRoute());
    } on FirebaseAuthException catch(e){
      throw PFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw PFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const PFormatException();
    } on PlatformException catch(e){
      throw PPlatformException(e.code).message;
    } catch (e){
      throw 'Something went Wrong. Try Again';
    }
  }
}