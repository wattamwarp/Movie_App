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

  int listLength,dif,cuurIndex,count;

  @override
  void onInit() {
    // TODO: implement onInit

    listLength=0;
    dif=0;
    cuurIndex=0;
    count=-1;
    super.onInit();
  }

  goToMovieDetail(BuildContext context){

    Navigator.pushNamed(
      context,
      '/movieDetails',
    );

  }

  addRows(int add){

    dif = listLength - count;

    if(dif >=10){

      for(var i =count;i<(count+9);i++)
        {

          tempList.add(searchList[i]);
          count = count +1;
        }
    }else{

      for( var i =count;i<(dif+ count);i++)
      {

        tempList.add(searchList[i]);
        count = count +1;
      }
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
    count=0;
    if(name == null || name.length==0||name.isEmpty){
      noData(true);
    }
    else{
      noData(false);
    }
    try {
      isLoading(true);
      var list = await searchMoviesService.searchMovies(name,1);
      if (list != null) {
        tempList.value.clear();

        listLength = searchList.length;
         searchList.value = list;

         if(searchList.length< 10){
           count = searchList.length;
           tempList=searchList;

         }else{
           int i=0;
           for(i=0;i<10;i++){
             tempList.add(searchList[i]);
              count++;
           }
         }
      }
    } finally {
      isLoading(false);
    }
  }


}