import 'package:cat_tinder_pro/domain/entities/cat.dart';

class LikedCatsState {
  final String? filterBreed;

  const LikedCatsState({required this.filterBreed});
}

class CatsLoading extends LikedCatsState {
  CatsLoading({required super.filterBreed});
}

class InitialState extends LikedCatsState {
  InitialState() : super(filterBreed: null);
}

class CatsLoadedState extends LikedCatsState {
  final List<Cat> cats;

  CatsLoadedState({required this.cats, required super.filterBreed});
}

class CatsLoadError extends LikedCatsState {
  final String? message;

  CatsLoadError({super.filterBreed = null, this.message = null});
}
