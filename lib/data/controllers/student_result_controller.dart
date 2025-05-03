import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:result/data/models/semester_model.dart';
import 'package:result/data/models/semester_wise_result_list_model.dart';
import 'package:result/data/utils/urls.dart';

class StudentResultController extends GetxController {
  List semesterList = [];
  bool searchingInProgress = false;
  @override
  onInit() {
    super.onInit();
    getSemesterList();
  }

  getSemesterList() async {
    semesterList.clear();
    try {
      final response = await get(Uri.parse(AppUrls.allSemesterIdNameUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        for (var semesterData in jsonData) {
          semesterList.add(SemesterModel.fromJson(semesterData));
        }
      } else {
        Get.snackbar(
            response.statusCode.toString(), 'Failed to load semesterData');
      }
    } catch (e) {
      Get.snackbar(e.toString(), 'Failed to get request for semesters data');
    }
  }

  List studentCompledtedSemesters = [];

  getStudentCompletedSemester(String studentId) {
    studentCompledtedSemesters.clear();
    if (semesterList.isNotEmpty) {
      final studentIdInitialAsString = studentId.split('-').first;
      if (studentIdInitialAsString.isNotEmpty) {
        int studentIdInitial = int.parse(studentIdInitialAsString);
        for (SemesterModel semester in semesterList) {
          final semesterId = int.parse(semester.semesterId);
          if (semesterId >= studentIdInitial) {
            studentCompledtedSemesters.add(semester);
          }
        }
      }
    }
  }

  List studentResults = [];
  List oneSemResult = [];
  getStudentResult(String studentId) async {
    searchingInProgress = true;
    update();
    getStudentCompletedSemester(studentId);
    studentResults.clear();
    oneSemResult.clear();
    for (SemesterModel studentCompledtedSemester
        in studentCompledtedSemesters) {
      final response = await get(Uri.parse(AppUrls.semesterResultUrl(
          studentCompledtedSemester.semesterId.toString(), studentId)));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        SemesterWiseResultListModel semesterWiseResultListModel =
            SemesterWiseResultListModel.fromJson(jsonData);
        oneSemResult = semesterWiseResultListModel.resultList;
      }
      if (oneSemResult.isNotEmpty) {
        studentResults.add({
          'oneSemRes': oneSemResult,
        });
        update();
      }
    }
    searchingInProgress = false;
    update();
  }
}
