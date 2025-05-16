import 'package:cat_tinder_pro/domain/entities/cat.dart';

abstract class CatRepository {
  Future<Cat?> getRandomCat();

  void likeCat(Cat cat);

  void removeCat(Cat cat);

  List<Cat> getLikedCats();
}
