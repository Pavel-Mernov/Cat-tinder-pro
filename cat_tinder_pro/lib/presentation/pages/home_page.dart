import 'package:cat_tinder_pro/presentation/blocs/cat_blocs/cat_bloc/cat_bloc.dart';
import 'package:cat_tinder_pro/presentation/pages/cat_detail_page.dart';
import 'package:cat_tinder_pro/presentation/pages/liked_cats_page.dart';
import 'package:cat_tinder_pro/presentation/widgets/cat_image_card.dart';
// import 'package:cat_tinder_pro/presentation/widgets/connection_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Tinder Pro'),

        actions: [
          // const ConnectionSnackbar(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LikedCatsPage()),
              );
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: BlocBuilder<CatBloc, CatState>(builder: _buildMainBody),
    );
  }

  Widget _buildMainBody(BuildContext context, CatState state) {
    if (state is CatError) {
      return Center(child: Text(state.message));
    }
    if (state is CatLoaded) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CatDetailPage(cat: state.cat)),
          );
        },
        child: Column(
          children: [
            Expanded(
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.horizontal,
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    context.read<CatBloc>().add(OnDislikeCat(cat: state.cat));
                  } else if (direction == DismissDirection.startToEnd) {
                    context.read<CatBloc>().add(OnLikeCat(cat: state.cat));
                  }
                },
                child: CatImageCard(cat: state.cat),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Like: ${state.likeCount} times',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_down, color: Colors.red),
                  onPressed:
                      () => context.read<CatBloc>().add(
                        OnDislikeCat(cat: state.cat),
                      ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.thumb_up, color: Colors.green),
                  onPressed:
                      () => context.read<CatBloc>().add(
                        OnLikeCat(cat: state.cat),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }

    return Center(child: const Text('Tap to load a cat'));
  }
}
