import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seedapp/domain/entities/movie.dart';
import 'package:seedapp/presentation/provider/providers.dart';

//este provider me va a retornar solo 6 peliculas de t
final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];


 //que me retorne solo 6 peliculas
  return nowPlayingMovies.sublist(0, 6);
});
