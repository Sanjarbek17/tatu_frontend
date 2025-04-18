import 'user.dart';
import 'school_year.dart';

class StudentProfile {
  final int id; // Added ID field
  final User user;
  final SchoolYear? schoolYear;

  StudentProfile({required this.id, required this.user, this.schoolYear});

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      id: json['id'],
      user: User.fromJson(json['user']),
      schoolYear:
          json['schoolYear'] != null
              ? SchoolYear.fromJson(json['schoolYear'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'schoolYear': schoolYear?.toJson(),
    };
  }
}
