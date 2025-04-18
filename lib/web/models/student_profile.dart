import 'school_year.dart';

class StudentProfile {
  final int id; // Added ID field
  final String username;
  final String email;
  final SchoolYear? schoolYear;

  StudentProfile({
    required this.id,
    required this.username,
    required this.email,
    this.schoolYear,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      schoolYear:
          json['schoolYear'] != null
              ? SchoolYear.fromJson(json['schoolYear'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'schoolYear': schoolYear?.toJson(),
    };
  }
}
