import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:seedapp/infrastructure/repositories/actor_repository_impl.dart';

import '../../../infrastructure/datasources/actor_moviedb_datasource.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});
