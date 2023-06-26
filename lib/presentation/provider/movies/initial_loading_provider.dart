import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seedapp/presentation/provider/providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {

  final step1 = ref.watch( nowPlayingMoviesProvider ).isEmpty;
  final step2 = ref.watch( popularMoviesProvider ).isEmpty;
  final step3 = ref.watch( topRatedMoviesProvider ).isEmpty;
  final step4 = ref.watch( upcomingMoviesProvider ).isEmpty;

  //si alguna de las 4 listas esta vacia, no terminamos de cargar pero si no estan vacias terminamos de cargar
  if( step1 || step2 || step3 || step4 ) return true;

   return false; // terminamos de cargar
});