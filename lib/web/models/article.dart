class Article {
  final int id;
  final String title;
  final String description;
  final String file;
  final DateTime createdAt;
  final int professor; // Changed to int
  final int schoolYear; // Changed to int

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
      professor: json['professor'], // Changed to directly use int
      schoolYear: json['school_year'], // Changed to directly use int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'file': file,
      'created_at': createdAt.toIso8601String(), // Fixed key to match backend
      'professor': professor, // Changed to int
      'school_year': schoolYear, // Changed to int
    };
  }
}
