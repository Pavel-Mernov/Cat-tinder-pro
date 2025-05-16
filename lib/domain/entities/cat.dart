import 'package:equatable/equatable.dart';

class Cat extends Equatable {
  final String id;

  final String breedName;

  final String description;

  final String imageUrl;

  Cat({
    required this.id,
    required this.breedName,
    required this.description,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id];
}
