
import 'package:cat_tinder_pro/domain/entities/cat.dart';
import 'package:cat_tinder_pro/domain/repositories/cat_repository.dart';

class LikeCat {
  final CatRepository repository;

  LikeCat({required this.repository});

  void call(Cat cat) async {
    repository.likeCat(cat);
  }
}