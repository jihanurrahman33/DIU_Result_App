class PersonalInfoModel {
  late String studentName;
  late String progShortName;
  late String studentId;
  late int batchNo;

  PersonalInfoModel.fromJson(Map<String, dynamic> jsonData) {
    studentName = jsonData['studentName'] ?? '';
    progShortName = jsonData['progShortName'] ?? '';
    studentId = jsonData['studentId'] ?? '';
    batchNo = jsonData['batchNo'] ?? '';
  }
}
