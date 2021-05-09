import 'package:flutter/material.dart';
import 'package:flutter_app_movie/Model/GetMoviesModel.dart';
import 'package:flutter_app_movie/Services/GetMoviesService.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetMoviesController extends GetxController{

  GetMoviesServices getMoviesServices=new GetMoviesServices();

  var moviesList = List<Result>().obs;
  var a = 0.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchMovies();
    super.onInit();
  }

  goToMovieDetail(BuildContext context){

    Navigator.pushNamed(
      context,
      '/movieDetails',
    );

  }

  setMovie(Result data, BuildContext context){
    _setMovieId(data,context);
  }

  _setMovieId(Result data , BuildContext context) async {
    String lang;
    if(data.originalLanguage.toString() =="en"){
      lang="English";
    }else{
      lang="Non-English";
    }


    SharedPreferences pref= await SharedPreferences.getInstance();
    pref.setString("original_title", data.originalTitle);
    pref.setString("overview", data.overview);
    pref.setString("original_language",lang );
    pref.setString("popularity", data.popularity.toString());
    pref.setString("poster_path", data.posterPath);
    pref.setString("release_date", data.releaseDate.toString());
    pref.setString("title", data.title);
    pref.setString("vote_average", data.voteAverage.toString());
    pref.setString("vote_count", data.voteCount.toString());
    pref.setString("Id", data.id.toString());
    print("the shared "+ pref.getString("poster_path"));

    goToMovieDetail(context);
  }

  void fetchMovies() async {
    try {
      isLoading(true);
      var list = await getMoviesServices.getMovies();
      if (list != null) {
        moviesList.value = list;
      }
    } finally {
      isLoading(false);
    }
  }

}