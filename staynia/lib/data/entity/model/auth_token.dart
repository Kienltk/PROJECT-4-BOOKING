class AuthToken {
  final String token;
  final String? refreshToken;
  final int? expiration;
  final String? scope;
  final int? refreshExpiration;
  final int createdAt;

  AuthToken({
    required this.token,
    required this.refreshToken,
    required this.expiration,
    required this.scope,
    required this.createdAt,
    required this.refreshExpiration,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['token'],
      refreshToken: json['refreshToken'] as String?,
      expiration: json['expiration'] as int?,
      scope: json['scope'] as String?,
      refreshExpiration: json['refreshExpiration'] as int?,
      createdAt:
          json['created_at'] ?? (DateTime.now().millisecondsSinceEpoch ~/ 1000),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'expiration': expiration,
      'scope': scope,
      'refreshExpiration': refreshExpiration,
      'createdAt': createdAt,
    };
  }

  AuthToken copyWith({
    String? token,
    String? refreshToken,
    int? expiration,
    String? scope,
    int? refreshExpiration,
     int? createdAt,
  }) {
    return AuthToken(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      expiration: expiration ?? this.expiration,
      scope: scope ?? this.scope,
      createdAt: createdAt ?? this.createdAt,
      refreshExpiration: refreshExpiration ?? this.refreshExpiration,
    );
  }
}
