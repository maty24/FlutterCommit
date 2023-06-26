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
    //mando a llamar el datasource del getNowPlaying
    return datasource.getNowPlaying(page: page);
  }
}
