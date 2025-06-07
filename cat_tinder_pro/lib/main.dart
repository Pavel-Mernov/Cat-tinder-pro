import 'package:cat_tinder_pro/presentation/blocs/cat_blocs/cat_bloc/cat_bloc.dart';
import 'package:cat_tinder_pro/presentation/blocs/cat_blocs/liked_cats_bloc/liked_cats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart' as di;

import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CatBloc(repository: di.getIt())),
        BlocProvider(create: (_) => LikedCatsBloc(repository: di.getIt())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Tinder Pro',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => di.getIt<CatBloc>()..add(OnFetchCat()),
        child: const HomePage(),
      ),
    );
  }
}
