import 'package:flutter/material.dart';
import 'package:flutter_app_movie/Model/SearchMoviesModel.dart';
import 'package:flutter_app_movie/Services/SearchMoviesService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

class SearchMoviesController extends GetxController{

  SearchMoviesService searchMoviesService= new SearchMoviesService();

  var searchList = List<Result>().obs;
  var isLoading = true.obs;
  var noData= true.obs;

  @override
  void onInit() {
    // TODO: implement onInit

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
    if(data.originalLanguage=="en"){
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

  void fetchSearchedMovies(String name) async {
    if(name == null || name.length==0||name.isEmpty){
      noData(true);
    }
    else{
      noData(false);
    }
    try {
      isLoading(true);
      var list = await searchMoviesService.searchMovies(name);
      if (list != null) {
         searchList.value = list;
      }
    } finally {
      isLoading(false);
    }
  }


}