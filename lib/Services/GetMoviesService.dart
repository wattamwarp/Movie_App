import 'dart:convert';
import 'package:flutter_app_movie/Model/GetMoviesModel.dart';
import 'package:http/http.dart' as http;

class GetMoviesServices {
  static var client = http.Client();

  Future<List<Result>> getMovies() async {
    Uri uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=a3fa19231e95aec0611c5d99110d10ef");

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var jsonString = json.decode(response.body);
      var data = GetMoviesModel.fromJson(jsonString);
      List<Result> list = data.results;
      return list;
    } else {
      return null;
    }
  }
}
