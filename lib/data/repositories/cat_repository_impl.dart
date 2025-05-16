import 'package:cat_tinder_pro/data/datasources/cat_remote_data_source.dart';
import 'package:cat_tinder_pro/domain/entities/cat.dart';
import 'package:cat_tinder_pro/domain/repositories/cat_repository.dart';

class CatRepositoryImpl extends CatRepository {
  final CatRemoteDataSource remoteDataSource;

  final List<Cat> _likedCats = [];

  CatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Cat?> getRandomCat() async {
    try {
      return await remoteDataSource.getRandomCat();
    } catch (e) {
      return null;
    }
  }

  @override
  List<Cat> getLikedCats() => List.unmodifiable(_likedCats);

  @override
  void likeCat(Cat cat) {
    if (!_likedCats.any((c) => c.id == cat.id)) {
      _likedCats.add(cat);
    }
  }

  @override
  void removeCat(Cat cat) {
    _likedCats.removeWhere((c) => c.id == cat.id);
  }
}
