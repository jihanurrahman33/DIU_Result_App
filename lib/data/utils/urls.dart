class AppUrls {
  static const String _baseUrl = 'http://software.diu.edu.bd:8006';

  static String personalInfoUrl(String studentId) =>
      '$_baseUrl/result/studentInfo?studentId=$studentId';
  static const String allSemesterIdNameUrl = '$_baseUrl/result/semesterList';

  static String semesterResultUrl(String semesterId, String studentId) =>
      "$_baseUrl/result?grecaptcha=&semesterId=$semesterId&studentId=$studentId";
}
