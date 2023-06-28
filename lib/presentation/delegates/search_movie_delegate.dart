import 'package:flutter/material.dart';
import 'package:seedapp/domain/entities/movie.dart';

//esto es para que se pueda usar el showSearch
class SearchMovieDelegate extends SearchDelegate<Movie?> {

 @override
 //esto es el texto que se muestra en la parte de arrina
 String get searchFieldLabel => 'Buscar pelicula';



  @override
  //esto retorna una lista de widgets que son los que se van a mostrar en la parte de arriba
  List<Widget>? buildActions(BuildContext context) {
    return [
      const Text('BuildActions'),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('BuildActions');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text('BuildActions');
  }
}
