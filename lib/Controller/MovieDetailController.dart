
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class MovieDetailController extends GetxController{

  var id = "".obs;
  var originalLanguage= "".obs;
  var originalTitle= "".obs;
  var overview= "".obs;
  var popularity= "".obs;
  var posterPath= "".obs;
  var title= "".obs;
  var video= "".obs;
  var voteAverage= "".obs;
  var voteCount= "".obs;
  var releaseDate= "".obs;

  var isLoading= true.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    //getMovieData();

    super.onInit();
  }

  getMovieData() async {

    isLoading.value=true;

    SharedPreferences pref = await SharedPreferences.getInstance();
    id.value = pref.getString("id");
    originalLanguage.value = pref.getString("original_language");
    originalTitle.value= pref.getString("original_title");
    overview.value = pref.getString("overview");
    popularity.value= pref.getString("popularity");
    posterPath.value= pref.getString("poster_path");
    title.value=pref.getString("title");
    voteAverage.value= pref.getString("vote_average");
    voteCount.value= pref.getString("vote_count");
    releaseDate.value= pref.getString("release_date");

    print("the path is "+ posterPath.value.toString());

    isLoading.value=false;

  }


}