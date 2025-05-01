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
  final List<SemesterWiseResultModel> _oneSemResultList = [];
  List studentAllSemesterResultList = [];

  List<SemesterWiseResultModel> get oneSemResultList => _oneSemResultList;

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

  Future<void> fetchStudentResult(String studentId) async {
    _searchingInProgress = true;
    update();

    _oneSemResultList.clear();
    studentAllSemesterResultList.clear();

    final String url = AppUrls.semesterResultUrl("251", studentId);
    final response = await get(Uri.parse(url));

    _logger.i('URL => $url');

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        try {
          final decodedJson = jsonDecode(response.body);

          for (var subjectResult in decodedJson) {
            _oneSemResultList
                .add(SemesterWiseResultModel.fromJson(subjectResult));
          }

          if (_oneSemResultList.isNotEmpty) {
            studentAllSemesterResultList.add({
              'semesterName': _oneSemResultList[0].semesterName,
              'semesterYear': _oneSemResultList[0].semesterYear,
              'cgpa': _oneSemResultList[0].cgpa,
              'courses': _oneSemResultList,
            });
          }
        } catch (e) {
          _logger.e("Error parsing semester results: $e");
          Get.snackbar("Error", "Invalid data format in semester result.");
        }
      } else {
        _logger.w("Empty response body for student result");
        Get.snackbar("Error", "No data found for this student.");
      }
    } else {
      _logger.e("Request failed: ${response.statusCode}");
      Get.snackbar(
          "Error", "Failed to load result. Code: ${response.statusCode}");
    }

    _searchingInProgress = false;
    update();
  }
}
