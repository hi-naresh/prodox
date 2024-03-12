import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prodox/data/repo/auth/auth_repo.dart';
import 'package:prodox/features/personalisation/controller/user_controller.dart';

import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/helpers/network_manager.dart';

class LoginController extends GetxController{
  static LoginController get instance => Get.find();

  //variables
  final rememberMe =false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email =TextEditingController();
  final password =TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  //function login
  Future<void> emailLogin() async{
    try{
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        PHelper.showSnackBar("No Internet", "Please check your internet connection");
        return;
      }
      //check form
      if (!loginFormKey.currentState!.validate()) {
        PHelper.showSnackBar("Invalid Form", "Please fill the form correctly");
        return;
      }
      if(rememberMe.value){
        final String rememberEmail= email.text.trim().toString();
        final String rememberPass = password.text.trim().toString();
        localStorage.writeIfNull("REMEMBER_ME_EMAIL", rememberEmail);
        localStorage.writeIfNull("REMEMBER_ME_PASSWORD",rememberPass );
      }

      final userCredentials = AuthRepo.instance.loginUser(email.text.trim(), password.text.trim());
      //redirect
      PHelper.showSnackBar("Logged in successfully", "Welcome back!");
      AuthRepo.instance.screenRedirect();

    }catch(e){
      PHelper.showSnackBar("Oh no!", e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        PHelper.showSnackBar("No Internet", "Please check your internet connection");
        return;
      }
      final userCredentials = await AuthRepo.instance.signInWithGoogle();
      //redirect
      await userController.saveUserRecord(userCredentials);

      PHelper.showSnackBar("Logged in successfully", "Welcome back!");
      AuthRepo.instance.screenRedirect();
    } catch (e) {
      PHelper.showSnackBar("Oh no!", e.toString());
    }
  }

  @override
  void onInit() {
    // email.text = localStorage.read("REMEMBER_ME_EMAIL").toString();
    // password.text = localStorage.read("REMEMBER_ME_PASSWORD").toString();
    super.onInit();
  }

}