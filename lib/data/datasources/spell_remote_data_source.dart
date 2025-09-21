import 'package:dio/dio.dart';
import '../models/spell_model.dart';
import '../../network/rest_client.dart';
import '../../network/hp_urls.dart';

abstract class SpellRemoteDataSource {
  Future<List<SpellModel>> getAllSpells();
}

class SpellRemoteDataSourceImpl implements SpellRemoteDataSource {
  final RestClient restClient;

  SpellRemoteDataSourceImpl({required this.restClient});

  @override
  Future<List<SpellModel>> getAllSpells() async {
    try {
      final response = await restClient.get(HpUrls.spells);
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => SpellModel.fromJson(json)).toList();
    } on DioException {
      rethrow;
    }
  }
}