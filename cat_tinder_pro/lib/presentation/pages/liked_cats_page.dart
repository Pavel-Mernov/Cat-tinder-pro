import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_tinder_pro/domain/entities/cat.dart';
import 'package:cat_tinder_pro/presentation/blocs/cat_blocs/cat_bloc/cat_bloc.dart';
import 'package:cat_tinder_pro/presentation/blocs/cat_blocs/liked_cats_bloc/liked_cats_bloc.dart';
import 'package:cat_tinder_pro/presentation/blocs/cat_blocs/liked_cats_bloc/liked_cats_state.dart';
import 'package:cat_tinder_pro/presentation/pages/cat_detail_page.dart';
// import 'package:cat_tinder_pro/presentation/widgets/connection_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikedCatsPage extends StatelessWidget {
  late final LikedCatsBloc bloc;

  LikedCatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bloc = context.read<LikedCatsBloc>();

    bloc.add(OnGetLikeCatsQuery(breed: null));

    return Scaffold(
      appBar: AppBar(title: const Text('Liked Cats')),
      body: BlocBuilder<LikedCatsBloc, LikedCatsState>(builder: _buildMainBody),
    );
  }

  Widget _buildMainBody(BuildContext context, LikedCatsState state) {
    return Column(
      children: [
        // _buildBreedFilter(context, state),
        Expanded(child: _buildExpandedBody(context, state)),
      ],
    );
  }

  Widget _buildExpandedBody(BuildContext context, LikedCatsState state) {
    if (state is CatsLoadedState) {
      final filtered = state.cats;

      return filtered.isEmpty
          ? const Center(child: Text('Нет лайкнутых котиков.'))
          : _buildListView(filtered);
    }

    if (state is CatsLoadError) {
      return Expanded(
        child: const Text(
          'Ошибка загрузки',
          style: TextStyle(color: Colors.red, fontSize: 24),
        ),
      );
    }

    return Expanded(child: CircularProgressIndicator());
  }

  Future _removeCat(Cat cat) async {
    bloc.repository.dislikeCat(cat);
  }

  Widget _buildListView(List<Cat> cats) {
    try {
      return ListView.builder(
        itemCount: cats.length,
        itemBuilder: (context, index) {
          final cat = cats[index];
          return Dismissible(
            key: ValueKey(cat.id),
            onDismissed: (_) => _removeCat(cat),

            background: Container(color: Colors.red),
            child: GestureDetector(
              onTap: () {
                // go to cat page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CatDetailPage(cat: cat)),
                );
              },
              child: _buildCatTile(cat),
            ),
          );
        },
      );
    } catch (e) {
      print("List build error. $e");

      return Expanded(
        child: const Text(
          'Ошибка отрисовки списка',
          style: TextStyle(color: Colors.red, fontSize: 24),
        ),
      );
    }
  }

  Widget _buildCatTile(Cat cat) {
    return ListTile(
      leading: CachedNetworkImage(imageUrl: cat.url, width: 56, height: 56),
      title: Text(cat.name),
      subtitle: Text(cat.description, maxLines: 1),
    );
  }

  /*
  Widget _buildBreedFilter(BuildContext context, LikedCatsState state) {

    if (state.allBreeds != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          hint: const Text('Фильтр по породе'),
          value: state.selectedBreed,
          isExpanded: true,
          items: [
            const DropdownMenuItem(value: null, child: Text('Все')),
            ...state.allBreeds!.map(
              (breed) => DropdownMenuItem(value: breed, child: Text(breed)),
            ),
          ],
          onChanged: (value) {
            bloc.add(OnGetLikeCatsQuery(breed: value));
          },
        ),
      );
    }

    return CircularProgressIndicator();
  }
  */
}
