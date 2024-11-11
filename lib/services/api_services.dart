import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:result/models/semester_info_model.dart';
import 'package:result/models/student_info_model.dart';
import 'package:result/models/student_semester_result_model.dart';

class ApiServices {
  Future<StudentInfoModel> getStudentInfo(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return StudentInfoModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load student info: ${response.statusCode}');
    }
  }

//getting all semester data
  Future<List<dynamic>> getSemesteInfo(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      return parseSemesters(jsonData);
    } else {
      throw Exception('Failed to load student info: ${response.statusCode}');
    }
  }

  //getting Studentsemesters result
  getSemesterResult(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return StudentSemesterResultModel().parsedResult(jsonData);
    } else {
      throw Exception('Unable to fetch data: ${response.statusCode}');
    }
  }
}
