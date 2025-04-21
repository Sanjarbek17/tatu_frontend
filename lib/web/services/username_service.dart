import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tatu_frontend/web/constants.dart';

class UsernameService {
  Future<bool> checkUsername(String username) async {
    final url = Uri.parse('$baseUrl/api/check-username/$username/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return data['username_exists'] ?? false;
    } else {
      throw Exception('Failed to check username');
    }
  }
}
