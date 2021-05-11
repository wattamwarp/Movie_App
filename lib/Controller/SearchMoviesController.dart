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
  var indicator= false.obs;

  var tempList=List<Result>().obs;
  bool load=true;


  int listLength,dif,cuurIndex,count;

  @override
  void onInit() {
    // TODO: implement onInit

    listLength=0;
    dif=0;
    cuurIndex=0;
    count=1;
    super.onInit();
  }

  goToMovieDetail(BuildContext context){

    Navigator.pushNamed(
      context,
      '/movieDetails',
    );

  }

  addRows(String name){
    _addRows(name);
  }
  _addRows(String name) async {


    try {
      //isLoading(true);
      if(load) {
        load=false;
        print("count is " + count.toString());
        var list = await searchMoviesService.searchMovies(name, count);


        tempList.addAll(list);

        print("temp list length is " + tempList.length.toString());
        await Future.delayed(Duration(seconds: 5));
        count++;
        print("after count is" + count.toString());

        load=true;
      }

    } finally {
    }

  }


  setMovie(Result data, BuildContext context){
    _setMovieId(data,context);
  }

  _setMovieId(Result data , BuildContext context) async {
    String lang;
    if(data.originalLanguage.toString()=="en"){
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
    count=1;
    tempList.clear();
    print("temp list start len is"+tempList.length.toString());
    print("cleared count is"+count.toString());
    if(name == null || name.length==0||name.isEmpty){
      noData(true);
    }
    else{
      noData(false);
    }
    try {
      count=1;
      isLoading(true);
      var list = await searchMoviesService.searchMovies(name,count);
      if (list != null)

          tempList.value =list;

count=2;
    } finally {
      isLoading(false);
    }
  }


}