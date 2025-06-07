import 'package:cat_tinder_pro/data/databases/cat_table.dart';
import 'package:cat_tinder_pro/data/datasources/cat_remote_data_source.dart';
import 'package:cat_tinder_pro/domain/connection_listeners/connection_listener.dart';
import 'package:cat_tinder_pro/domain/entities/cat.dart';
import 'package:cat_tinder_pro/domain/repositories/cat_repository.dart';

class CatRepositoryImpl extends CatRepository {
  final CatRemoteDataSource remoteDataSource;

  final CatTable database;

  final ConnectionListener connectionListener;

  CatRepositoryImpl({
    required this.remoteDataSource,
    required this.database,
    required this.connectionListener,
  });

  @override
  Future<Cat?> getRandomCat() async {
    final hasConnection = await connectionListener.checkConnection();

    print('Trying to connect. Connection: $hasConnection');

    if (hasConnection) {
      Cat? newCat = null;

      try {
        newCat = await remoteDataSource.getRandomCat();

        print('New cat: $newCat');

        await database.insertCat(newCat);

        return newCat;
      } catch (e) {
        print('Error load: $e');
      }
    }
    return database.getRandomCat();
  }

  @override
  Future likeCat(Cat cat) async {
    final newCat = cat.setLiked(true);

    await database.updateCat(newCat);
  }

  @override
  Future dislikeCat(Cat cat) async {
    final newCat = cat.setLiked(false);

    await database.updateCat(newCat);
  }

  @override
  Future<List<String>> getBreedNames() async {
    return await database.getUniqueNames();
  }

  @override
  Future<List<Cat>> getLikedCats({String? breed = null}) =>
      database.getLikedCats(breed: breed);
}
