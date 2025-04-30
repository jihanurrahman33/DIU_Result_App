class AppUrls {
  static const String _baseUrl = 'https://diurecords.vercel.app/api';

  static String personalInfoUrl(String studentId) =>
      '$_baseUrl/result/studentInfo?studentId=$studentId';
  static const String allSemesterIdNameUrl = '$_baseUrl/result/semesterList';

  static String semesterResultUrl(String semesterId, String studentId) =>
      "$_baseUrl/result?grecaptcha=&semesterId=$semesterId&studentId=$studentId";
}
