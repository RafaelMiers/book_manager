import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_exception.dart';

class ApiClient {
  final String baseUrl;
  final http.Client _client;
  String? _authToken;

  ApiClient({required this.baseUrl, http.Client? client})
      : _client = client ?? http.Client();

  void setAuthToken(String token) => _authToken = token;
  void clearAuthToken() => _authToken = null;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (_authToken != null) 'Authorization': 'Bearer $_authToken',
      };

  Future<dynamic> get(String path) async {
    final response = await _client.get(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
    );
    return _handleResponse(response);
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> put(String path, Map<String, dynamic> body) async {
    final response = await _client.put(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String path) async {
    final response = await _client.delete(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    final body = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }
    throw ApiException(
      statusCode: response.statusCode,
      message: body['message'] ?? 'Unknown error',
    );
  }
}
