import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/constants/api_constants.dart';
import 'package:frontend/core/failure/failure.dart';
import 'package:frontend/features/auth/model/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<Either<ApiFailure, UserModel>> signup({
    // will return either 'AppFailure' for failure or 'UserModel' for success
    required String name,
    required String email,
    required String password,
  }) async {
    debugPrint("Repo Name: $name\nEmail: $email\npass: $password");
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.signup),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        return Left(ApiFailure(responseBody['detail']));
      }
      debugPrint('Response - ${response.statusCode} = ${response.body}');

      return Right(UserModel.fromMap(responseBody));
    } catch (c) {
      return Left(ApiFailure('$c'));
    }
  }

  Future<Either<ApiFailure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    debugPrint("Login email: $email\nPassword: $password");
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return Left(ApiFailure(responseBody['detail']));
      }

      debugPrint("Login respone - ${response.statusCode} - ${response.body}");

      return Right(UserModel.fromMap(responseBody));
    } catch (c) {
      return Left(ApiFailure('$c'));
    }
  }
}
