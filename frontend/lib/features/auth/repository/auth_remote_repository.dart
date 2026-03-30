import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String baseUrl = "http://127.0.0.1:8000"; // for desktop app
// String baseUrl = "http://192.168.1.228:8000";   // for actual device
// String baseUrl = "https://harry-syngamic-poetically.ngrok-free.dev";   // universal
// String baseUrl = "http://10.0.2.2:8000";   // for emulator

class AuthRemoteRepository {
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    debugPrint("Repo Name: $name\nEmail: $email\npass: $password");
    final response = await http.post(
      Uri.parse("$baseUrl/auth/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    debugPrint('Response - ${response.statusCode} = ${response.body}');
  }

  Future<void> login({required String email, required String password}) async {
    debugPrint("Login email: $email\nPassword: $password");
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'password': password}),
      );
      debugPrint("Login respone - ${response.statusCode} - ${response.body}");
    } catch (c) {
      debugPrint('$c');
    }
  }
}
