class User {
  final String email;
  final String password;
  final String name;

  User({required this.email, required this.name, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'name': name};
  }
}
