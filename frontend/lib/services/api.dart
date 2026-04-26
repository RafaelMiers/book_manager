import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Use 10.0.2.2 for Android emulator, localhost for iOS sim
  static const baseUrl = 'http://10.0.2.2:8000';

  static Future<String> fetchGreeting() async {
    final res = await http.get(Uri.parse('$baseUrl/'));
    if (res.statusCode == 200) {
      return jsonDecode(res.body)['message'];
    }
    throw Exception('Failed to load');
  }
}