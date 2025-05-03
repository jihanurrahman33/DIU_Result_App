import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:result/data/models/personal_info_model.dart';
import 'package:result/data/services/network_client.dart';
import 'package:result/data/utils/urls.dart';

class PersonalInfoController extends GetxController {
  PersonalInfoModel? personalInfo;

  final Logger _logger = Logger();

  Future<bool> getPersonalInfo(String studentId) async {
    final response =
        await NetworkClient.getRequest(url: AppUrls.personalInfoUrl(studentId));

    if (response.isSucess && response.data != null) {
      try {
        personalInfo = PersonalInfoModel.fromJson(response.data!);

        update();
      } catch (e) {
        _logger.e("Error parsing personal info: $e");
        Get.snackbar("Error", "Failed to parse student info.");
      }
    } else {
      Get.snackbar('Error', response.errorMessage ?? "Unknown error");
    }
    return response.isSucess;
  }
}
