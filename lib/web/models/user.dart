class User {
  final String username;
  final String email;
  final bool isProfessor;
  final bool isStudent;

  User({
    required this.username,
    required this.email,
    required this.isProfessor,
    required this.isStudent,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      isProfessor: json['isProfessor'],
      isStudent: json['isStudent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'isProfessor': isProfessor,
      'isStudent': isStudent,
    };
  }
}
