import 'user.dart';

class ProfessorProfile {
  final User user;
  final String? bio;
  final String? department;

  ProfessorProfile({required this.user, this.bio, this.department});

  factory ProfessorProfile.fromJson(Map<String, dynamic> json) {
    return ProfessorProfile(
      user: User.fromJson(json['user']),
      bio: json['bio'],
      department: json['department'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'bio': bio, 'department': department};
  }
}
