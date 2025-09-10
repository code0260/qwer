// ignore_for_file: public_member_api_docs, sort_constructors_first
class TokenModel {
  String? accessToken;
  String? refreshToken;
  String? expires;

  // Constructor
  TokenModel({this.accessToken, this.refreshToken, this.expires});

  // method to create a Token from a JSON map
  TokenModel fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    expires = json['expires'];
    return this;
  }

  // Method to convert a Token to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires': expires,
    };
  }

  @override
  String toString() =>
      'TokenModel(accessToken: $accessToken, refreshToken: $refreshToken, expires: $expires)';

  TokenModel copyWith({
    String? accessToken,
    String? refreshToken,
    String? expires,
  }) {
    this.accessToken = accessToken ?? this.accessToken;
    this.refreshToken = refreshToken ?? this.refreshToken;
    this.expires = expires ?? this.expires;
    return this;
  }
}
