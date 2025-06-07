import 'package:cat_tinder_pro/domain/entities/cat.dart';

abstract class CatRepository {
  Future<Cat?> getRandomCat();

  Future likeCat(Cat cat);

  Future dislikeCat(Cat cat);

  Future<List<Cat>> getLikedCats({String? breed = null});

  Future<List<String>> getBreedNames();
}
