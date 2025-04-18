class SchoolYear {
  final int id; // Added ID field
  final String name;
  final DateTime startDate;
  final DateTime endDate;

  SchoolYear({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  factory SchoolYear.fromJson(Map<String, dynamic> json) {
    return SchoolYear(
      id: json['id'],
      name: json['name'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}
