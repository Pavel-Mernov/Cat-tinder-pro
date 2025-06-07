import 'dart:math';

import 'package:cat_tinder_pro/data/models/cat_model.dart';
import 'package:cat_tinder_pro/domain/entities/cat.dart';
import 'package:dio/dio.dart';

class CatRemoteDataSource {
  final Dio dio;

  CatRemoteDataSource({required this.dio});

  // get list of all breeds

  Future<List<String>> _getBreedIds() async {
    final path = 'https://api.thecatapi.com/v1/breeds';

    final responce = await dio.get(path);

    final data = responce.data as List;

    return data.map((json) => json['id'] as String).toList();
  }

  Future<Map<String, dynamic>> _getBreedById(String id) async {
    final path = 'https://api.thecatapi.com/v1/breeds/${id}';

    final responce = await dio.get(path);

    final data = responce.data as Map<String, dynamic>;

    return data;
  }

  Future<Cat> getRandomCat() async {
    final breedIds = await _getBreedIds();

    // breedIds.forEach(print); // for debug

    if (breedIds.isEmpty) {
      throw Exception('Не удалось загрузить список пород.');
    }

    final randomBreedId = breedIds[Random().nextInt(breedIds.length)];

    final response = await dio.get(
      'https://api.thecatapi.com/v1/images/search',
      queryParameters: {
        'limit': 1,
        'has_breeds': 1,
        'breed_ids': randomBreedId,
      },
    );

    final data = response.data as List;

    // print("Breed found: " + data.length.toString()); // debug

    if (data.isEmpty) {
      throw Exception('Нет изображений для породы $randomBreedId');
    }

    final catJson = data[0] as Map<String, dynamic>;

    final breedInfo = await _getBreedById(randomBreedId);

    catJson["name"] = breedInfo["name"];
    catJson["description"] = breedInfo["description"];

    // print("Cat json:"); // debug
    // print(catJson); // debug

    final catModel = CatModel.fromJson(catJson);

    // print(catModel); // debug

    return catModel;
  }
}
