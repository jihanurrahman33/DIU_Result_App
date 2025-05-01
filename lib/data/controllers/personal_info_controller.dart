import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:result/data/models/all_semester_list_model.dart';
import 'package:result/data/models/personal_info_model.dart';
import 'package:result/data/models/semester_wise_result_model.dart';

import 'package:result/data/services/network_client.dart';
import 'package:result/data/utils/urls.dart';

class PersonalInfoController extends GetxController {
  bool _searchingInProgress = false;
  bool get searchingInProgress => _searchingInProgress;
  PersonalInfoModel? personalInfo;
  List<AllSemesterListModel> studentAllSemesterList = [];
  List<SemesterWiseResultModel> _oneSemResultList = [];
  List studentAllSemesterResultList = [];
  List<SemesterWiseResultModel> get oneSemResultList => _oneSemResultList;
  Future<void> getPersonalInfo(String studentId) async {
    final response =
        await NetworkClient.getRequest(url: AppUrls.personalInfoUrl(studentId));
    if (response.isSucess) {
      personalInfo = PersonalInfoModel.fromJson(response.data!);
      update();
      //await fetchStudentCompletedSem(studentId);
    } else {
      Get.snackbar('Error', response.errorMessage!);
    }
  }

  // Future<void> fetchStudentCompletedSem(String studentId) async {
  //   final _logger = Logger();
  //   studentAllSemesterList.clear();
  //   String studentInitial = studentId.substring(0, 3);
  //   int stdInitialAsInt = int.parse(studentInitial);
  //   final response = await get(Uri.parse(AppUrls.allSemesterIdNameUrl));
  //   _logger.i('URL=> ${AppUrls.allSemesterIdNameUrl}'
  //       'Body=> ${response.body}');
  //   if (response.statusCode == 200) {
  //     final listJsonData = jsonDecode(response.body);
  //     for (var jsonData in listJsonData) {
  //       if (jsonData['semesterId'] != null &&
  //           jsonData['semesterId'] >= stdInitialAsInt) {
  //         studentAllSemesterList.add(AllSemesterListModel.fromJson(jsonData));
  //       }
  //     }
  //     update();
  //   } else {
  //     Get.snackbar(
  //         snackPosition: SnackPosition.BOTTOM,
  //         response.statusCode.toString(),
  //         response.body);
  //   }
  // }

  Future<void> fetchStudentResult(String studentId) async {
    _searchingInProgress = true;
    update();
    _oneSemResultList.clear();
    studentAllSemesterResultList.clear();
    Logger _logger = Logger();
    //for (var semesterId in studentAllSemesterList) {
    final response = await get(Uri.parse(AppUrls.semesterResultUrl(
        // semesterId.semesterId.toString(),
        251.toString(),
        studentId)));
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      _logger.i('URL=>${AppUrls.semesterResultUrl(251.toString(), studentId)}'
          'Response Body=> $decodedJson');
      for (var subjectResult in decodedJson) {
        _oneSemResultList.add(SemesterWiseResultModel.fromJson(subjectResult));
      }
      studentAllSemesterResultList.add({
        'semesterName': _oneSemResultList[0].semesterName,
        'semesterYear': _oneSemResultList[0].semesterYear,
        'cgpa': _oneSemResultList[0].cgpa,
        'courses': _oneSemResultList
      });
      _searchingInProgress = false;
      update();
      // }
    }
  }
}
