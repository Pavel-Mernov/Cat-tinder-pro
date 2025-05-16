import 'package:cat_tinder_pro/domain/entities/cat.dart';
import 'package:cat_tinder_pro/domain/repositories/cat_repository.dart';

class GetRandomCat {
  final CatRepository repository;

  GetRandomCat({required this.repository});

  Future<Cat?> call() async {
    return await repository.getRandomCat();
  }
}
