import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seedapp/presentation/provider/movies/movies_providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _HomeView());
  }
}

/*
//lo traformamos en un stateful widget para poder usar el init state, lo puedo convertir en un consumerStatefulWidger
class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {*/

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

//no le pongo el ref ya que estoy en consumerstafulwidget en todo este widget

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
//esto va a llamar al metodo loadNextPage y el watch va a estar escuchando el estado de la lista de peliculas
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    //nesecito estar escuchando el estado de la lista de peliculas
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    return ListView.builder(
      itemCount: nowPlayingMovies.length,
      itemBuilder: (context, index) {
        final movie = nowPlayingMovies[index];
        return ListTile(
          title: Text(movie.title),
        );
      },
    );
  }
}
