import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager_app/utils/storage_utils.dart';

class AuthService {
  final String _baseUrl = 'https://dummyjson.com/auth';

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      body: jsonEncode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Save data locally using shared preferences
      await StorageUtil.saveUserData(data);
      return true;
    } else {
      return false;
    }
  }
}
