class SemesterModel {
  late String semesterId;
  late int semesterYear;
  late String semesterName;

  SemesterModel.fromJson(Map<String, dynamic> jsondata) {
    semesterId = jsondata['semesterId'] ?? '';
    semesterYear = jsondata['semesterYear'] ?? '';
    semesterName = jsondata['semesterName'] ?? '';
  }
}
