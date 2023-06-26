import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seedapp/infrastructure/datasources/moviedb_datasource.dart';
import 'package:seedapp/infrastructure/repositories/movie_repository_impl.dart';

//es el encargado de promover el repositorio
final movieRepositoryProvider = Provider((ref) {
  //la referencia es la implementacion del repositorio, y el repositorio necesita el datasource, que el datasource es que tiene los metodos para obtener los datos
  return MovieRepositoryImpl(MoviedbDatasource());
});
