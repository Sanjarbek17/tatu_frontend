import 'professor_profile.dart';
import 'school_year.dart';

class Article {
  final int id;
  final String title;
  final String description;
  final String file;
  final DateTime createdAt;
  final ProfessorProfile professor;
  final SchoolYear schoolYear;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.file,
    required this.createdAt,
    required this.professor,
    required this.schoolYear,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      file: json['file'],
      createdAt: DateTime.parse(json['createdAt']),
      professor: ProfessorProfile.fromJson(json['professor']),
      schoolYear: SchoolYear.fromJson(json['schoolYear']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'file': file,
      'createdAt': createdAt.toIso8601String(),
      'professor': professor.toJson(),
      'schoolYear': schoolYear.toJson(),
    };
  }
}
