import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/university.dart';

class ApiService {
  static Future<List<University>> fetchUniversities() async {
    final url = Uri.parse(
      'https://raw.githubusercontent.com/VarthanV/Indian-Colleges-List/refs/heads/master/colleges.json',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => University.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load universities');
    }
  }
}
