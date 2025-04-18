class SchoolYear {
  final String name;
  final DateTime startDate;
  final DateTime endDate;

  SchoolYear({
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  factory SchoolYear.fromJson(Map<String, dynamic> json) {
    return SchoolYear(
      name: json['name'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}
