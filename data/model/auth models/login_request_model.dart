// lib/data/model/auth models/login_request_model.dart

class LoginRequestModel {
  final String email;
  final String password;
  // يمكن إضافة branch_id هنا إذا تطلب الأمر مستقبلاً

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  /// هذه الدالة تحول بيانات الموديل إلى JSON
  /// هذه هي الطريقة النظيفة لتجهيز البيانات للـ API
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}