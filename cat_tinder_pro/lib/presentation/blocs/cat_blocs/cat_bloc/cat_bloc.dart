import 'package:bloc/bloc.dart';
import 'package:cat_tinder_pro/domain/entities/cat.dart';
import 'package:cat_tinder_pro/domain/repositories/cat_repository.dart';
import 'package:equatable/equatable.dart';

part 'cat_event.dart';
part 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final CatRepository repository;

  int likeCount = 0;

  CatBloc({required this.repository}) : super(CatInitial()) {
    on<OnFetchCat>(_onFetchCat);
    on<OnLikeCat>(_onLikeCat);
    on<OnDislikeCat>(_onDislikeCat);
  }

  Future<void> _onFetchCat(OnFetchCat event, Emitter<CatState> emit) async {
    // emit(CatLoading());

    final cat = await repository.getRandomCat();

    if (cat == null) {
      emit(CatError(message: 'Failed to load cat info'));
    } else {
      emit(CatLoaded(cat: cat, likeCount: likeCount));
    }
  }

  Future<void> _onLikeCat(OnLikeCat event, Emitter<CatState> emit) async {
    likeCount++;

    repository.likeCat(event.cat);

    add(OnFetchCat());
  }

  Future<void> _onDislikeCat(OnDislikeCat event, Emitter<CatState> emit) async {
    add(OnFetchCat());
  }
}
