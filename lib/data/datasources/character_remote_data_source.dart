import 'package:dio/dio.dart';
import '../models/character_model.dart';
import '../../network/rest_client.dart';
import '../../network/hp_urls.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getAllCharacters();
  Future<List<CharacterModel>> getStudents();
  Future<List<CharacterModel>> getStaff();
  Future<List<CharacterModel>> getCharactersByHouse(String house);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final RestClient restClient;

  CharacterRemoteDataSourceImpl({required this.restClient});

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    try {
      final response = await restClient.get(HpUrls.characters);
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => CharacterModel.fromJson(json)).toList();
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<List<CharacterModel>> getStudents() async {
    try {
      final response = await restClient.get(HpUrls.students);
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => CharacterModel.fromJson(json)).toList();
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<List<CharacterModel>> getStaff() async {
    try {
      final response = await restClient.get(HpUrls.staff);
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => CharacterModel.fromJson(json)).toList();
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<List<CharacterModel>> getCharactersByHouse(String house) async {
    try {
      final response = await restClient.get('${HpUrls.charactersInHouse}/$house');
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => CharacterModel.fromJson(json)).toList();
    } on DioException {
      rethrow;
    }
  }
}