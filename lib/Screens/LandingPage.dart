//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_movie/Controller/GetMoviesController.dart';
import 'package:flutter_app_movie/Controller/SearchMoviesController.dart';
import 'package:flutter_app_movie/Model/GetMoviesModel.dart';
import 'package:flutter_app_movie/Services/GetMoviesService.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
//import 'package:meet_network_image/meet_network_image.dart';

class LandinPage extends StatefulWidget {
  @override
  _LandinPageState createState() => _LandinPageState();
}

class _LandinPageState extends State<LandinPage> {
  GetMoviesController getMovieCon = Get.put(GetMoviesController());
  SearchMoviesController searchMoviesController =
      Get.put(SearchMoviesController());

  TextEditingController search = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          //color: Colors.amberAccent,
          child: Column(
            children: [
              Container(
                height: 40,
                // color: Colors.red,
                width: _width,
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: TextField(
                    controller: search,
                    onChanged: (value) {
                      setState(() {
                        searchMoviesController
                            .fetchSearchedMovies(value.toString());
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Movie',
                    ),
                  ),
                ),
              ),
              Expanded(
                //height: _height - 60,
                child: Column(
                  children: [
                    Container(
                      height: 270,
                      width: _width,
                      // color: Colors.pink,
                      child: Obx(() {
                        if (getMovieCon.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else
                          return new Swiper(
                            itemCount: 4,
                            //res_data.length,
                            viewportFraction: 0.9,
                            scale: 0.95,
                            loop: false,
                            //duration: 300,
                            autoplay: true,
                            autoplayDelay: 6000,
                            //index: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  //height: 220,
                                  width: _width,
                                  //color: Colors.red,
                                  child: Card(
                                    elevation: 6,
                                    // color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    shadowColor: Colors.transparent,
                                    child: Container(
                                      // height: 320,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 200,
                                            width: _width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Material(
                                              elevation: 0,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20)),
                                                child: Image.network(
                                                  "https://image.tmdb.org/t/p/original/${getMovieCon.moviesList[index].posterPath.toString()}",
                                                  fit: BoxFit.fill,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent
                                                              loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // height: 50,
                                            margin: EdgeInsets.only(top: 8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 12),
                                                      child: Text(
                                                        getMovieCon
                                                            .moviesList[index]
                                                            .originalTitle
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 12),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            getMovieCon
                                                                .moviesList[
                                                                    index]
                                                                .voteAverage
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16),
                                                          ),
                                                          Container(
                                                              child: Icon(
                                                            Icons.star,
                                                            size: 16,
                                                          ))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 6),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 12),
                                                        child: Text(
                                                          getMovieCon
                                                              .moviesList[index]
                                                              .originalLanguage
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: 12),
                                                        child: Text(
                                                          getMovieCon
                                                              .moviesList[index]
                                                              .popularity
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          );
                      }),
                    ),
                    Expanded(
                      // height: 200,
                      child: Container(
                        // / height: 20,

                        child: Obx(() {
                           if (searchMoviesController.noData.value ==
                          true) {
                          return Center(
                          child: Text("search something in search bar"),
                          );
                          }
                          else if (searchMoviesController.isLoading.value == true) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }  else
                            return ListView.builder(
                              itemCount:
                                  searchMoviesController.searchList.length,
                              itemBuilder: (context, index) {

                                return InkWell(
                                  onTap: (){
                                    searchMoviesController.setMovie(searchMoviesController.searchList[index]);
                                  },
                                  child: Card(
                                    child: Container(
                                      height: 150,
                                      child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 150,
                                                  width: 100,
                                                  child: Image.network(
                                                    "https://image.tmdb.org/t/p/original/${searchMoviesController.searchList[index].posterPath.toString()}",
                                                    fit: BoxFit.fill,
                                                    loadingBuilder:
                                                        (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent
                                                        loadingProgress) {
                                                      if (loadingProgress == null)
                                                        return child;
                                                      return Center(
                                                        child:
                                                        CircularProgressIndicator(),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  width: _width - 110,
                                                  height: 150,
                                                  //color: Colors.red,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width:_width - 190,
                                                              margin: EdgeInsets.only(
                                                                  left: 12),
                                                              child: Text(
                                                                searchMoviesController.searchList[index]
                                                                    .originalTitle
                                                                    .toString(),
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    fontSize: 16),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                  right: 12),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    searchMoviesController.searchList[
                                                                    index]
                                                                        .voteAverage
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                        fontSize: 16),
                                                                  ),
                                                                  Container(
                                                                      child: Icon(
                                                                        Icons.star,
                                                                        size: 16,
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        margin:
                                                        EdgeInsets.only(top: 6),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                  left: 12),
                                                              child: Text(
                                                                searchMoviesController.searchList[index]
                                                                    .originalLanguage
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize: 12),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                  right: 12),
                                                              child: Text(
                                                                searchMoviesController.searchList[index]
                                                                    .popularity
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize: 12),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width:_width - 110,
                                                        margin: EdgeInsets.only(
                                                            left: 12,top: 18),
                                                        child: Text(
                                                          searchMoviesController.searchList[index]
                                                              .overview
                                                              .toString(),
                                                          maxLines: 4,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              fontSize: 10),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),


                                              ],
                                            ),
                                          ],
                                        ),
                                    ),

                                  ),
                                );
                              },
                            );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
