import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seedapp/presentation/provider/providers.dart';
import 'package:seedapp/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      //parte de abajo de la pantalla
      bottomNavigationBar: CustomBottomNavigation(),
    );
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

    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    //este provider esta encargado de ver si todas las peliculas estan cargadas
    final initialLoading = ref.watch(initialLoadingProvider);
    // si todas las peliculas no estan cargadas se muestra el fullScreenLoader
    if (initialLoading) return const FullScreenLoader();

   ///////////////////providers de las peliculas/////////////////////

    //estoy llamdno el provider que tiene las 6 peliculas
    final nowPlayinMovies6peliss = ref.watch(moviesSlideshowProvider);

    //nesecito estar escuchando el estado de la lista de peliculas
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    //el  customscrollview es un scrollview que me permite tener varios slivers
    return CustomScrollView(
        //el sliver es un widget que me permite tener varios hijos
        slivers: [
          //el sliverappbar es el widget que me permite tener un appbar que se puede ocultar y al subir se muestra
          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: //este es el widget de la parte de arriba de la pantalla
                  CustomAppbar(),
            ),
          ),

          //este sliverList es el que me permite tener varios hijos
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                //este es el widget del slider de las peliculas
                MoviesSlideshow(movies: nowPlayinMovies6peliss),

                //estas son las peliculas que se van a mostras en la mitad de la app
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En Cines',
                  subTitle: 'Lunes 20',
                  //le envio el metodo loadNextPage
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage(),
                ),

                MovieHorizontalListview(
                    movies: upcomingMovies,
                    title: 'Próximamente',
                    subTitle: 'En este mes',
                    loadNextPage: () => ref
                        .read(upcomingMoviesProvider.notifier)
                        .loadNextPage()),

                MovieHorizontalListview(
                    movies: popularMovies,
                    title: 'Populares',
                    // subTitle: '',
                    loadNextPage: () => ref
                        .read(popularMoviesProvider.notifier)
                        .loadNextPage()),

                MovieHorizontalListview(
                    movies: topRatedMovies,
                    title: 'Mejor calificadas',
                    subTitle: 'Desde siempre',
                    loadNextPage: () => ref
                        .read(topRatedMoviesProvider.notifier)
                        .loadNextPage()),

                const SizedBox(height: 15),
              ],
            );
          }, childCount: 1))
        ]);
  }
}
