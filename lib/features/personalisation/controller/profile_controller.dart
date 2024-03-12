import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prodox/data/repo/auth/auth_repo.dart';
import 'package:prodox/routes.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final deviceStorage = GetStorage();

  @override
  void onReady() {
    super.onReady();
  }

  //logout user
  void logoutUser() async {
    try{
      await AuthRepo.instance.logoutUser();
      await deviceStorage.erase();
      Get.offAllNamed(PRoutes.getOnBoardingRoute());
    } catch (e){
      throw 'Something went Wrong. Try Again';
    }
  }
}