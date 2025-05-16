import 'package:cat_tinder_pro/core/di/injection_container.dart';
import 'package:cat_tinder_pro/domain/entities/cat.dart';
import 'package:cat_tinder_pro/domain/repositories/cat_repository.dart';
import 'package:cat_tinder_pro/presentation/pages/cat_detail_page.dart';
import 'package:flutter/material.dart';

class LikedCatsPage extends StatefulWidget {
  const LikedCatsPage({super.key});

  @override
  State<LikedCatsPage> createState() => _LikedCatsPageState();
}

class _LikedCatsPageState extends State<LikedCatsPage> {
  String? selectedBreed;

  late final CatRepository catRepository;
  late List<Cat> allCats;

  @override
  void initState() {
    super.initState();
    catRepository = getIt<CatRepository>();
    allCats = catRepository.getLikedCats();
  }

  void _removeCat(Cat cat) {
    catRepository.removeCat(cat);
    setState(() {
      allCats = catRepository.getLikedCats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered =
        selectedBreed == null
            ? allCats
            : allCats.where((cat) => cat.breedName == selectedBreed).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Liked Cats')),
      body: Column(
        children: [
          _buildBreedFilter(),
          Expanded(
            child:
                filtered.isEmpty
                    ? const Center(child: Text('Нет лайкнутых котиков.'))
                    : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final cat = filtered[index];
                        return Dismissible(
                          key: ValueKey(cat.id),
                          onDismissed: (_) => _removeCat(cat),
                          
                          background: Container(color: Colors.red),
                          child: 
                          GestureDetector(
                            onTap: () {
                              // go to cat page
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (_) => CatDetailPage(cat: cat)),
                              );
                            },
                            child: _buildCatTile(cat),
                          )
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildCatTile(Cat cat) {
    return 
      ListTile(
        leading: Image.network(
          cat.imageUrl,
          width: 56,
          height: 56,
        ),
          title: Text(cat.breedName),
          subtitle: Text(cat.description, maxLines: 1),
      );
  }

  Widget _buildBreedFilter() {
    final breeds = allCats.map((e) => e.breedName).toSet().toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<String>(
        hint: const Text('Фильтр по породе'),
        value: selectedBreed,
        isExpanded: true,
        items: [
          const DropdownMenuItem(value: null, child: Text('Все')),
          ...breeds.map(
            (breed) => DropdownMenuItem(value: breed, child: Text(breed)),
          ),
        ],
        onChanged: (value) {
          setState(() {
            selectedBreed = value;
          });
        },
      ),
    );
  }
}
