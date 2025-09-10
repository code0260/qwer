// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserInputModel {
  int? usersId;
  int? usersBusinessId;
  int? usersActive;
  String? usersName;
  String? usersEmail;
  String? usersPassword;
  String? usersPhone;
  String? usersType;
  String? usersPowers;
  String? usersCreatedAt;

  bool? logoutFromOtherDevices;
  UserInputModel(
      {this.usersId,
      this.usersActive,
      this.usersBusinessId,
      this.usersName,
      this.usersEmail,
      this.usersPassword,
      this.usersPhone,
      this.usersType,
      this.usersPowers,
      this.usersCreatedAt,
      this.logoutFromOtherDevices});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'users_id': usersId,
      'users_business_id': usersBusinessId,
      'users_name': usersName,
      'users_type': usersType,
      'users_powers': usersPowers,
      'users_active': usersActive,
      'users_email': usersEmail,
      'users_password': usersPassword,
      'users_phone': usersPhone,
      'logout': logoutFromOtherDevices,
      'users_createdAt': usersCreatedAt != null
          ? DateTime.parse(usersCreatedAt!).toUtc().toString()
          : null,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
