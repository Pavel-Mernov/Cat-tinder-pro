part of 'cat_bloc.dart';

abstract class CatEvent extends Equatable {
  const CatEvent();

  @override
  List<Object?> get props => [];
}

class OnFetchCat extends CatEvent {}

class OnLikeCat extends CatEvent {
  final Cat cat;

  const OnLikeCat({required this.cat});
}

class OnDislikeCat extends CatEvent {
  final Cat cat;

  const OnDislikeCat({required this.cat});
}

class OnGetLikeCatsQuery extends CatEvent {
  final String? breed;

  OnGetLikeCatsQuery({required this.breed});
}
