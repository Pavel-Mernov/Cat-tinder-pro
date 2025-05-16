import 'package:flutter/material.dart';
import '../../domain/entities/cat.dart';

class CatDetailPage extends StatelessWidget {
  final Cat cat;

  const CatDetailPage({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cat.breedName)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Картинка котика
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                cat.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
              ),
            ),
            const SizedBox(height: 16),

            // Название породы
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                cat.breedName,
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
