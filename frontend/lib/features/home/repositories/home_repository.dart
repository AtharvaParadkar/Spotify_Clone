import 'dart:developer';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:frontend/core/constants/api_constants.dart';
import 'package:frontend/core/failure/failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<ApiFailure, String>> uploadSong({
    required File selectAudio,
    required File selectThumbnail,
    required String songName,
    required String artist,
    required String hexCode,
    required String token,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstants.uploadSong),
      );

      request
        ..files.addAll([
          await http.MultipartFile.fromPath('song', selectAudio.path),
          await http.MultipartFile.fromPath('thumbnail', selectThumbnail.path),
        ])
        ..fields.addAll({
          'artist': artist,
          'song_name': songName,
          'hex_code': hexCode,
        })
        ..headers.addAll({'x-auth-token': token});

      log("WWEWDSDWDDW $request");
      final res = await request.send();

      if (res.statusCode != 201) {
        return Left(ApiFailure(await res.stream.bytesToString()));
      }
      log("ressss ${res.statusCode}\n${res.reasonPhrase}");
      return Right(await res.stream.bytesToString());
    } catch (c) {
      return Left(ApiFailure(c.toString()));
    }
  }
}
