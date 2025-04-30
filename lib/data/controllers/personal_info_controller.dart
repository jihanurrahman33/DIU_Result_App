import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';
import 'package:result/data/models/all_semester_list_model.dart';
import 'package:result/data/models/personal_info_model.dart';
import 'package:result/data/services/network_client.dart';
import 'package:result/data/utils/urls.dart';

class PersonalInfoController extends GetxController {
  PersonalInfoModel? personalInfo;
  List<AllSemesterListModel> diuAllSemesterList = [];
  Future<void> getPersonalInfo(String studentId) async {
    final response =
        await NetworkClient.getRequest(url: AppUrls.personalInfoUrl(studentId));
    if (response.isSucess) {
      personalInfo = PersonalInfoModel.fromJson(response.data!);
      update();
      fetchStudentCompletedSem(studentId);
    } else {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
    }
  }

  Future<void> fetchStudentCompletedSem(String studentId) async {
    String studentInitial = studentId.substring(0, 3);
    int stdInitialasInt = int.parse(studentInitial);
    final response = await get(Uri.parse(AppUrls.allSemesterIdNameUrl));
    if (response.statusCode == 200) {
      final listJsonData = jsonDecode(response.body);
      for (var jsonData in listJsonData) {
        if (jsonData['semesterId'] >= stdInitialasInt) {
          diuAllSemesterList.add(AllSemesterListModel.fromJson(jsonData));
        }
      }
    }
  }

  Future<void> fetchStudentResult(String studentId) async {
    for (var semesterId in diuAllSemesterList) {
      final response = await NetworkClient.getRequest(
        url: AppUrls.semesterResultUrl(
          semesterId.semesterId.toString(),
          studentId,
        ),
      );
      if (response.isSucess) {
      } else {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
      }
    }
  }
}
