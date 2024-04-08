import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart'
    show serverUrl;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<dynamic> approveFlyingVisit(Map data) async {
  const storage = FlutterSecureStorage();
  final String? jwt = await storage.read(key: 'jwt');
  dynamic response = await http.post(
      Uri.parse('$serverUrl/teacher/invigilation/approve-flying-visit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt',
      },
      body: jsonEncode(data));
  return response;
}
