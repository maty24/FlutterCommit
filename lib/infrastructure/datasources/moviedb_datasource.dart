import 'package:dio/dio.dart';

import 'package:seedapp/config/constants/enviroments.dart';
import 'package:seedapp/domain/datasources/movies_datasource.dart';
import 'package:seedapp/domain/entities/movie.dart';
import 'package:seedapp/infrastructure/mappers/movie_mapper.dart';
import 'package:seedapp/infrastructure/models/moviedb/moviedb_response.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');

     //estoy convirtiendo el json a un objeto de dart que es la respuesta de la api
    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    //estoy 
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movies;
  }
}
