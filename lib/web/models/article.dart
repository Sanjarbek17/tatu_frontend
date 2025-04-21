import 'package:tatu_frontend/web/models/professor_profile.dart';
import 'package:tatu_frontend/web/models/school_year.dart';

class Article {
  final int id;
  final String title;
  final String description;
  final String file;
  final DateTime createdAt;
  final ProfessorProfile professor; // Changed to int
  final SchoolYear schoolYear; // Changed to int

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.file,
    required this.createdAt,
    required this.professor, // Changed to int
    required this.schoolYear, // Changed to int
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      file: json['file'],
      createdAt: DateTime.parse(json['created_at']),
      professor: ProfessorProfile.fromJson(json['professor']), // Changed to directly use int
      schoolYear: SchoolYear.fromJson(json['school_year']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'file': file,
      'created_at': createdAt.toIso8601String(), // Fixed key to match backend
      'professor': professor.toJson(), // Changed to int
      'school_year': schoolYear.toJson(), // Changed to int
    };
  }
}
