class UserModel {
  final String? username;
  final String? email;
  final String? password;
  final String? accessToken;
  final String? refreshToken;
  final String? avatar;

  UserModel(
      {this.email,
      this.password,
      this.username,
      this.accessToken,
      this.avatar,
      this.refreshToken});

  Map<String, dynamic> toJsonForRegistration() {
    return {"username": username, "email": email, "password": password};
  }

  Map<String, dynamic> toJsonForLogin() {
    return {"username": username, "password": password};
  }

  factory UserModel.fromJsonForTokens({required Map<String, dynamic> map}) {
    return UserModel(
        accessToken: map["access_token"], refreshToken: map["refresh_toekn"]);
  }

  factory UserModel.fromJsonForPostProfile(
      {required Map<String, dynamic> map}) {
    return UserModel(avatar: map["avatar"], username: map["username"]);
  }

  factory UserModel.fromJsonForGetUser({required Map<String, dynamic> map}) {
    return UserModel(avatar: map["avatar"], username: map["username"]);
  }
}
