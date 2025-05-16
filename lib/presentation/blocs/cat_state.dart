part of 'cat_bloc.dart';

abstract class CatState extends Equatable {
  const CatState();

  @override
  List<Object?> get props => [];
}

class CatInitial extends CatState {}

class CatLoading extends CatState {}

class CatLoaded extends CatState {
  final Cat cat;
  final int likeCount;

  const CatLoaded({required this.cat, required this.likeCount});

  @override
  List<Object?> get props => [cat, likeCount];
}

class CatError extends CatState {
  final String message;

  const CatError({required this.message});

  @override
  List<Object?> get props => [message];
}
