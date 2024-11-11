class StudentSemesterResultModel {
  String? semesterId;
  String? semesterName;
  String? cgpa;

  StudentSemesterResultModel({
    this.semesterId,
    this.semesterName,
    this.cgpa,
  });

  factory StudentSemesterResultModel.fromJson(Map<String?, dynamic> json) {
    return StudentSemesterResultModel(
      semesterId: json['semesterId'],
      semesterName: json['semesterName'],
      cgpa: json['cgpa'].toString(),
    );
  }

  List<dynamic> parsedResult(List<dynamic> jsonList) {
    return jsonList
        .map((json) => StudentSemesterResultModel.fromJson(json))
        .toList();
  }
}
