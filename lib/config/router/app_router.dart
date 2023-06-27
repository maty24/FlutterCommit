import 'package:go_router/go_router.dart';
import 'package:seedapp/presentation/screen/screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        name: HomeScreen.name,
        builder: (context, state) => const HomeScreen(),
        //rutas hijas de esta ruta
        routes: [
          GoRoute(
              path: 'movie/:movieId',
              name: MovieScreen.name,
              builder: (context, state) {
                //estoy sacando el id de la url y si no hay nada le pongo no-id
                final movieId = state.params['movieId'] ?? 'no-id';
                return MovieScreen(movieId: movieId);
              }),
        ]),
  ],
);
