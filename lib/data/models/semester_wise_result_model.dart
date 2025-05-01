class SemesterWiseResultModel {
  late String semesterName;
  late int semesterYear;
  late String customCourseId;
  late String courseTitle;
  late double totalCredit;
  late double pointEquivalent;
  late String gradeLetter;
  late double cgpa;
  late String tevalSubmitted;

  SemesterWiseResultModel.fromJson(Map<String, dynamic> jsonData) {
    semesterName = jsonData['semesterName'] ?? '';
    semesterYear = jsonData['semesterYear'] ?? 0;
    customCourseId = jsonData['customCourseId'] ?? '';
    courseTitle = jsonData['courseTitle'] ?? '';
    totalCredit = jsonData['totalCredit'] ?? 0.0;
    pointEquivalent = jsonData['pointEquivalent'] ?? 0;
    gradeLetter = jsonData['gradeLetter'] ?? '';
    cgpa = jsonData['cgpa'] ?? 0;
    tevalSubmitted = jsonData['tevalSubmitted'];
  }

  Map<String, dynamic> toJson() {
    return {
      'semesterName': semesterName,
      'semesterYear': semesterYear,
      'customCourseId': customCourseId,
      'courseTitle': courseTitle,
      'totalCredit': totalCredit,
      'pointEquivalent': pointEquivalent,
      'gradeLetter': gradeLetter,
      'cgpa': cgpa,
      'tevalSubmitted': tevalSubmitted,
    };
  }
}
