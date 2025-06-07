import 'package:equatable/equatable.dart';

abstract class Cat extends Equatable {
  final String id;

  final String name;

  final String description;

  final String url;

  final bool isLiked;

  Cat({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.isLiked,
  });

  @override
  List<Object?> get props => [id];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'url': url,
    'isLiked': isLiked ? 1 : 0,
  };

  Cat setLiked(bool value);
}
