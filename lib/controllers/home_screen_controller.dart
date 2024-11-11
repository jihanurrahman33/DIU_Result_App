import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:result/models/student_info_model.dart';
import 'package:result/services/api_services.dart';
import 'package:result/utils/urls.dart';

class HomeScreenController extends GetxController {
  Rxn<StudentInfoModel> studentInfoData = Rxn<StudentInfoModel>();

  TextEditingController textFieldController = TextEditingController();

  RxList<dynamic> data = [].obs;

  textSubmitController(value) async {
    if (value.isNotEmpty) {
      await getStudentData(textFieldController.text);
      getStudentSemesters();
      data.value = await getResult();
      update();
    } else {
      studentInfoData.value = null;
      update();
    }
  }

  Future<void> getStudentData(value) async {
    try {
      studentInfoData.value =
          await ApiServices().getStudentInfo(AppUrls.personalInfoUrl(value));
    } catch (e) {
      throw Exception(e);
    }
  }

  //getting semester data and stroring in variable;
  List<dynamic> semesterinfo = [];
  getsemesterInfo() async {
    semesterinfo
        .add(await ApiServices().getSemesteInfo(AppUrls.allSemesterIdNameUrl));
  }

  @override
  void onInit() async {
    await getsemesterInfo();

    super.onInit();
  }

  //get studentId Inital
  getStudentIdInitial(String value) {
    final idInitial = value.substring(0, 3);
    return idInitial;
  }

  //store available all semester for student id
  List semesterIdList = [];
  List studentSemesterList = [];
  getStudentSemesters() {
    studentSemesterList.clear();
    semesterIdList.clear();
    semesterinfo[0].forEach(
      (info) {
        semesterIdList.add(info.semesterId);
      },
    );

    final studentIdInitial = getStudentIdInitial(textFieldController.text);
    for (var id in semesterIdList) {
      if (int.parse(id) >= int.parse(studentIdInitial)) {
        studentSemesterList.add(id);
      }
    }
  }

  // storeListResult
  List allsemesterStudentResult = [];

  RxInt semesterCounter = 0.obs;
  storeAllsemesterStudentResult(semesterId, studentId) async {
    List<dynamic> value = await ApiServices()
        .getSemesterResult(AppUrls.semesterResultUrl(semesterId, studentId));
    //print(value);
    bool isExisted = allsemesterStudentResult
        .any((result) => result[0].semesterId == semesterId);
    if (value.isNotEmpty) {
      if (!isExisted) {
        allsemesterStudentResult.add(value);
      }
      semesterCounter.value += 1;
    } else {
      print('value is empty');
    }
  }

  getResult() async {
    semesterCounter.value = 0;
    for (var semester in studentSemesterList) {
      await storeAllsemesterStudentResult(semester, textFieldController.text);
    }
    return allsemesterStudentResult;
  }
}
