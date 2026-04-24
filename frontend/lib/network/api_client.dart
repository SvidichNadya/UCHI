import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const baseUrl = 'http://localhost:8000/api';

  static Future<List<Map<String, dynamic>>> getChildSessions(int childId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/parents/sessions/$childId'),
      headers: {'Authorization': 'Bearer YOUR_JWT_TOKEN'},
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load sessions');
    }
  }

  static Future<void> sendTelemetry(Map<String, dynamic> payload) async {
    await http.post(
      Uri.parse('$baseUrl/telemetry/log'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer TOKEN'},
      body: jsonEncode(payload),
    );
  }
}