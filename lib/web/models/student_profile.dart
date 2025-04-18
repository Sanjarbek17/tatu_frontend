import 'user.dart';
import 'school_year.dart';

class StudentProfile {
  final User user;
  final SchoolYear? schoolYear;

  StudentProfile({required this.user, this.schoolYear});

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      user: User.fromJson(json['user']),
      schoolYear:
          json['schoolYear'] != null
              ? SchoolYear.fromJson(json['schoolYear'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'user': user.toJson(), 'schoolYear': schoolYear?.toJson()};
  }
}
