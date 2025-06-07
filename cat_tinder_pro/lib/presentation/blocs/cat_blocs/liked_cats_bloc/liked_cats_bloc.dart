import 'package:cat_tinder_pro/domain/repositories/cat_repository.dart';
import 'package:cat_tinder_pro/presentation/blocs/cat_blocs/cat_bloc/cat_bloc.dart';
import 'package:cat_tinder_pro/presentation/blocs/cat_blocs/liked_cats_bloc/liked_cats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikedCatsBloc extends Bloc<CatEvent, LikedCatsState> {
  final CatRepository repository;

  LikedCatsBloc({required this.repository}) : super(InitialState()) {
    on<OnGetLikeCatsQuery>(_onGetLikedCats);
  }

  Future<void> _onGetLikedCats(
    OnGetLikeCatsQuery event,
    Emitter<LikedCatsState> emit,
  ) async {
    emit(LikedCatsState(filterBreed: event.breed));

    try {
      final likedCats = await repository.getLikedCats();
      emit(CatsLoadedState(cats: likedCats, filterBreed: event.breed));
    } catch (e) {
      print("Load error. $e");

      emit(CatsLoadError(message: e.toString()));
    }
  }
}
