class StudentInfoModel {
  String? name;
  String? id;
  String? batch;
  String? program;

  StudentInfoModel({
    this.name,
    this.id,
    this.batch,
    this.program,
  });

  factory StudentInfoModel.fromJson(Map<String, dynamic> json) {
    if (json['studentName'] == null || json['studentId'] == null) {
      return StudentInfoModel(
        name: ' ',
        id: ' ',
        batch: ' ',
        program: ' ',
      );
    } else {
      return StudentInfoModel(
        name: json['studentName'],
        id: json['studentId'],
        batch: json['batchNo'].toString(),
        program: json['progShortName'],
      );
    }
  }
}
