import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cat_tinder_pro/presentation/widgets/connection_snackbar.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/cat.dart';

class CatDetailPage extends StatelessWidget {
  final Cat cat;

  const CatDetailPage({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat.name),
        actions: [
          // const ConnectionSnackbar(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: cat.url,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, _) => CircularProgressIndicator(),
                errorWidget:
                    (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                cat.name,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),

            // Описание
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                cat.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
