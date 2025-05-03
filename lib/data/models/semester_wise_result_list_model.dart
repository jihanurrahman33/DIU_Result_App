import 'package:result/data/models/semester_wise_result_model.dart';

class SemesterWiseResultListModel {
  late final List<SemesterWiseResultModel> resultList;

  SemesterWiseResultListModel.fromJson(List<dynamic> jsonData) {
    resultList =
        jsonData.map((data) => SemesterWiseResultModel.fromJson(data)).toList();
  }
}
