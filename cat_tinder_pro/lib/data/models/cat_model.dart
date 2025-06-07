import '../../domain/entities/cat.dart';

// ignore: must_be_immutable
class CatModel extends Cat {
  CatModel({
    required String id,
    required String name,
    required String description,
    required String url,
    final bool isLiked = false,
  }) : super(
         id: id,
         name: name,
         description: description,
         url: url,
         isLiked: isLiked,
       );

  static CatModel fromJson(Map<String, dynamic> breed) {
    return CatModel(
      id: breed['id'] ?? '',
      name: breed['name'] ?? '',
      description: breed['description'] ?? '',
      url: breed['url'] ?? '',
      isLiked: (breed.containsKey('isLiked') ? (breed['isLiked'] != 0) : false),
    );
  }

  @override
  String toString() {
    return "Breed. id = ${id}. name = ${name}. description: ${description}. Url: ${url}.";
  }

  @override
  Cat setLiked(bool value) {
    return CatModel(
      id: id,
      name: name,
      description: description,
      url: url,
      isLiked: value,
    );
  }
}
