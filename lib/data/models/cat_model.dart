import '../../domain/entities/cat.dart';

class CatModel extends Cat {
  CatModel({
    required String id,
    required String breedName,
    required String description,
    required String imageUrl,
  }) : super(
         id: id,
         breedName: breedName,
         description: description,
         imageUrl: imageUrl,
       );

  factory CatModel.fromJson(Map<String, dynamic> breed) {
    return CatModel(
      id: breed['id'] ?? '',
      breedName: breed['name'] ?? '',
      description: breed['description'] ?? '',
      imageUrl: breed['url'] ?? '',
    );
  }

  @override
  String toString() {
    return "Breed. id = ${id}. name = ${breedName}. description: ${description}. Url: ${imageUrl}.";
  }
}
