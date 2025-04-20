import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/school_year.dart';

class SchoolYearService {
  final String baseUrl;

  SchoolYearService(this.baseUrl);

  Future<List<SchoolYear>> getAllSchoolYears() async {
    final url = Uri.parse('$baseUrl/api/school-years/');

    try {
      final response = await http.get(url);
      print('response: ${response.body}'); // Debug print for response
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => SchoolYear.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load school years');
      }
    } catch (error) {
      print('Error fetching school years: $error');
      rethrow;
    }
  }
}
