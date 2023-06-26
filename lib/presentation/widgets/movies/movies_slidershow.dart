import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:seedapp/domain/entities/movie.dart';

//este widget es el slider de las peliculas que cambia automaticamente
class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
     final colors = Theme.of(context).colorScheme;
    return SizedBox(
        height: 210,
        //el dobule.infinity es para que ocupe todo el ancho de la pantalla
        width: double.infinity,
        child: Swiper(
          viewportFraction: 0.8,
          scale: 0.9,
          autoplay: true,
          pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary
          )
        ),
          itemCount: movies.length,
          itemBuilder: (context, index) =>
              //el index es el numero de la pelicula
              _Slide(movie: movies[index]),
        ));
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black54, blurRadius: 10, offset: Offset(0, 10))
        ]);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
                //esta es la imagen de la pelicula
                movie.backdropPath,
                //esto es para que la imagen se adapte al tamaño del widget
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
              //si esta cargando la imagen
              if (loadingProgress != null) {
                //si esta cargando la imagen muestra esto
                return const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black12),
                );
              }
              //si no esta cargando la imagen muestra lo que deberia ser la imagen
              return FadeIn(child: child);
            })),
      ),
    );
  }
}
