import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:result/data/controllers/personal_info_controller.dart';
import 'package:result/data/controllers/student_result_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(PersonalInfoController());
    Get.put(StudentResultController());
  }
}
