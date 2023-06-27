import 'package:seedapp/domain/datasources/movies_datasource.dart';
import 'package:seedapp/domain/entities/movie.dart';
import 'package:seedapp/domain/repositories/movies_repository.dart';

//esta implemtencaion es llamar el datasource y del datasource llamar estos metodos(funciones)
//esta implementacion se la voy a enviar el riverpod
class MovieRepositoryImpl extends MoviesRepository {
  //inyecto el datasource para poder usarlo
  final MoviesDatasource datasource;
  MovieRepositoryImpl(this.datasource);


  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }
  
  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }
}
