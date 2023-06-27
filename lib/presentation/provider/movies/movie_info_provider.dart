import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seedapp/domain/entities/movie.dart';
import 'package:seedapp/presentation/provider/providers.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  //ref es la referencia de la clase
  final movieRepository = ref.watch(movieRepositoryProvider);

  //estoy llamando la peticion de la api de la pelicula
  return MovieMapNotifier(
    //le mando la referencia de la peticion de la api, no la voy a ejecutar
    getMovie: movieRepository.getMovieById,
  );
});

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }) : super({});

  //esta va a ejecutar la peticion de la api y recibe el id de la pelicula
  Future<void> loadMovie(String movieId) async {
    //si el estado de la pelicula es diferente de null no hago nada  osea si ya tiene la pelicula no hago nada
    if (state[movieId] != null) return;

    //si no la tiene hago la peticion de la api
    final movie = await getMovie(movieId);

    //
    state = {...state, movieId: movie};
  }
}
