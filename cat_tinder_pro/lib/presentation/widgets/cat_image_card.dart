import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_tinder_pro/domain/entities/cat.dart';
import 'package:flutter/material.dart';

class CatImageCard extends StatelessWidget {
  final Cat cat;

  const CatImageCard({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: cat.url,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (_, _) => CircularProgressIndicator(),

              errorWidget:
                  (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.error)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(cat.name, style: const TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
