class UserModel {
  final String username;
  final String accessToken;
  final String refreshToken;

  UserModel({
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "access": accessToken,
      "refresh": refreshToken,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'],
      accessToken: map['access'],
      refreshToken: map['refresh'],
    );
  }

  UserModel copyWith({
    String? username,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserModel(
      username: username ?? this.username,
      accessToken: accessToken ?? this.username,
      refreshToken: refreshToken ?? this.username,
    );
  }
}
