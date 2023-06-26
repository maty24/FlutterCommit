import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seedapp/domain/entities/movie.dart';
import 'package:seedapp/presentation/provider/movies/movie_repository_provider.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  //uso el watch para obtener el provedor de la referencia
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  //retornamos la clase que es el estado que va a notificar y le pasamos los argumentos que necesita
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});




final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      //este provider tiene todas las peliculas populares
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//es un provedor de un estado que notifia su cambio, provedor de informacion que notifica su cambio
//el state es un listado de peliculas

//esto es el tipo de funcion que quiero que se ejecute
typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  //el super le pasamos el estado inicial que es una lista vacia
  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    //si esta cargando no se hace nada
    if (isLoading) return;

    //si no esta cargando se pone en true
    isLoading = true;

    //cada vez que se ejecuta el loadNextPage se incrementa la pagina
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
