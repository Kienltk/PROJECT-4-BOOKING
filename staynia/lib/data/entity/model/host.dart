class Host {
  final int id;
  final String username;
  final String fullName;
  final String email;
  final String phone;
  final int? type;
  final String? password;

  Host({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.phone,
    this.type,
    this.password,
  });

  factory Host.fromJson(Map<String, dynamic> json) {
    return Host(
      id: json['id'],
      username: json['username'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      type: json['type'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'type': type,
      'password': password,
    };
  }
}
