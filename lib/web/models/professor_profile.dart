import 'user.dart';

class ProfessorProfile {
  final int id; // Added ID field
  final User user;
  final String? bio;
  final String? department;

  ProfessorProfile({
    required this.id,
    required this.user,
    this.bio,
    this.department,
  });

  factory ProfessorProfile.fromJson(Map<String, dynamic> json) {
    return ProfessorProfile(
      id: json['id'],
      user: User.fromJson(json['user']),
      bio: json['bio'],
      department: json['department'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'bio': bio,
      'department': department,
    };
  }
}
