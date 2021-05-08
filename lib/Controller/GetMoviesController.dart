import 'package:flutter/material.dart';
import 'package:flutter_app_movie/Model/GetMoviesModel.dart';
import 'package:flutter_app_movie/Services/GetMoviesService.dart';
import 'package:get/get.dart';

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