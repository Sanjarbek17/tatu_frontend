class ProfessorProfile {
  final int id; // Added ID field
  final String username;
  final String email;
  final String? bio;
  final String? department;

  ProfessorProfile({
    required this.id,
    required this.username,
    required this.email,
    this.bio,
    this.department,
  });

  factory ProfessorProfile.fromJson(Map<String, dynamic> json) {
    return ProfessorProfile(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      bio: json['bio'],
      department: json['department'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'bio': bio,
      'department': department,
    };
  }
}
