import 'dart:convert';
import 'package:http/http.dart' as client;
import 'package:flutter_app_movie/Model/SearchMoviesModel.dart';

class SearchMoviesService {
  Future<List<Result>> searchMovies(String name) async {
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/search/movie?api_key=a3fa19231e95aec0611c5d99110d10ef&query=$name");

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonString = json.decode(response.body);
      var data = SearchMoviesModel.fromJson(jsonString);
      List<Result> list = data.results;

      print("main list length is"+list.length.toString());
      return list;
    } else {
      return null;
    }
  }
}
