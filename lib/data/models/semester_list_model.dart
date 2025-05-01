class SemesterListModel {
  late String semesterId;
  late String semesterYear;
  late List courses;

  SemesterListModel.fromJson(
    Map<String, dynamic> jsonData,
  ) {
    semesterId = jsonData['semesterId'];
    semesterYear = jsonData['semesterYear'];
    courses = jsonData['courses'];
  }
}
