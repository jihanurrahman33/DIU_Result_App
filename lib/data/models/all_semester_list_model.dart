class AllSemesterListModel {
  late int semesterId;
  late String semesterYear;
  late String semesterName;

  AllSemesterListModel.fromJson(Map<String, dynamic> jsondata) {
    semesterId = jsondata['semesterId'] ?? '';
    semesterYear = jsondata['semesterYear'] ?? '';
    semesterName = jsondata['semesterName'] ?? '';
  }
}
