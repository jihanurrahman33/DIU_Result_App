class AppUrls {
  static const String _baseUrl = 'http://software.diu.edu.bd:8006';
  static const String _baseUrl2 = 'http://203.190.10.22:8189';
  static String personalInfoUrl(String studentId) =>
      "$_baseUrl/result/studentInfo?studentId=$studentId";
  static String personalInfoUrl2(String studentId) =>
      '$_baseUrl2/result/studentInfo?studentId=$studentId';
  static const String allSemesterIdNameUrl2 = '$_baseUrl2/result/semesterList';

  static const String allSemesterIdNameUrl = "$_baseUrl/result/semesterList";

  static String semesterResultUrl(String semesterId, String studentId) =>
      "$_baseUrl/result?grecaptcha=&semesterId=$semesterId&studentId=$studentId";

  static String semesterResultUrl2(String semesterId, String studentId) =>
      "$_baseUrl/result?semesterId=$semesterId&studentId=$studentId";
}
