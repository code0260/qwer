// ignore_for_file: public_member_api_docs, sort_constructors_first

class AddBusinessModel {
  int? usersId;
  int? usersBusinessId;
  String? usersName;
  String? usersEmail;
  String? usersPassword;
  String? usersPhone;
  String? usersCreatedAt;
  int? businessId;
  String? businessName;
  String? businessAddress;
  String? businessImage;
  int? businessApprove;
  String? businessCreatedAt;

  AddBusinessModel({
    this.usersId,
    this.usersBusinessId,
    this.usersName,
    this.usersEmail,
    this.usersPassword,
    this.usersPhone,
    this.usersCreatedAt,
    this.businessId,
    this.businessName,
    this.businessAddress,
    this.businessImage,
    this.businessApprove,
    this.businessCreatedAt,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'users_id': usersId,
      'users_business_id': usersBusinessId,
      'users_name': usersName,
      'users_email': usersEmail,
      'users_password': usersPassword,
      'users_phone': usersPhone,
      'users_createdAt': usersCreatedAt != null
          ? DateTime.parse(usersCreatedAt!).toUtc().toString()
          : null,
      'business_id': businessId,
      'business_name': businessName,
      'business_address': businessAddress,
      'business_image': businessImage,
      'business_approve': businessApprove,
      'business_createdAt': businessCreatedAt != null
          ? DateTime.parse(businessCreatedAt!).toUtc().toString()
          : null,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
