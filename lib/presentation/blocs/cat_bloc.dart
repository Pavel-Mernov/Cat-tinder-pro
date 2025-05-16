import 'package:bloc/bloc.dart';
import 'package:cat_tinder_pro/domain/usecases/like_cat.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_random_cat.dart';
import '../../domain/entities/cat.dart';

part 'cat_event.dart';
part 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final GetRandomCat getRandomCat;
  final LikeCat likeCat;

  int likeCount = 0;

  CatBloc({
      required this.getRandomCat,
      required this.likeCat
    }) 
    : super(CatInitial()) {
    
    on<OnFetchCat>(_onFetchCat);
    on<OnLikeCat>(_onLikeCat);
    on<OnDislikeCat>(_onDislikeCat);
  }

  Future<void> _onFetchCat(OnFetchCat event, Emitter<CatState> emit) async {
    emit(CatLoading());

    final cat = await getRandomCat();

    if (cat == null) {
      emit(CatError(message: 'Failed to load cat info'));
    } else {
      emit(CatLoaded(cat: cat, likeCount: likeCount));
    }
  }

  Future<void> _onLikeCat(OnLikeCat event, Emitter<CatState> emit) async {
    likeCount++;
    
    likeCat(event.cat);

    add(OnFetchCat());
  }

  Future<void> _onDislikeCat(OnDislikeCat event, Emitter<CatState> emit) async {
    add(OnFetchCat());
  }
}
