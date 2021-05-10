//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_movie/Controller/GetMoviesController.dart';
import 'package:flutter_app_movie/Controller/SearchMoviesController.dart';

//import 'package:flutter_app_movie/Model/GetMoviesModel.dart';
import 'package:flutter_app_movie/Model/SearchMoviesModel.dart';
import 'package:flutter_app_movie/Services/GetMoviesService.dart';
import 'package:flutter_app_movie/Services/SearchMoviesService.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

import 'package:universal_platform/universal_platform.dart';
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
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    var fraction, scale;
    if (_width < 500) {
      fraction = 0.9;
      scale = 0.95;
    } else if (_width < 1000) {
      fraction = 0.40;
      scale = 0.95;
    } else {
      fraction = 0.20;
      scale = 0.95;
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          //color: Colors.amberAccent,
          color: Color(0xfffaf8f7),
          child: Column(
            children: [
              Container(
                height: 40,
                width: _width,
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 8, bottom: UniversalPlatform.isWeb ? 8 : 0),
                  child: Center(
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
              ),
              Expanded(
                //height: _height - 60,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 370,
                        width: _width,
                        // color: Colors.pink,
                        child: Obx(() {
                          if (getMovieCon.isLoading.value) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else
                            return new Swiper(
                              itemCount: getMovieCon.moviesList.length,
                              viewportFraction: fraction,
                              scale: scale,
                              loop: false,
                              autoplay: true,
                              autoplayDelay: 6000,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    getMovieCon.setMovie(
                                        getMovieCon.moviesList[index], context);
                                  },
                                  child: Container(
                                      width: _width,
                                      child: Card(
                                        elevation: 6,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        shadowColor: Colors.transparent,
                                        child: Container(
                                          // height: 320,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 300,
                                                width: _width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Material(
                                                  elevation: 0,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20)),
                                                    child: Image.network(
                                                      "https://image.tmdb.org/t/p/original${getMovieCon.moviesList[index].posterPath.toString()}",
                                                      fit: BoxFit.fill,
                                                      loadingBuilder: (BuildContext
                                                              context,
                                                          Widget child,
                                                          ImageChunkEvent
                                                              loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) return child;
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
                                                          //width:200,
                                                          constraints: BoxConstraints(minWidth: 50, maxWidth:_width< 700 &&_width>350 ? 110:200),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 12),
                                                          //color: Colors.red,
                                                          child: Text(
                                                            getMovieCon
                                                                .moviesList[
                                                                    index]
                                                                .originalTitle
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16),
                                                            maxLines: 1,
                                                            overflow:TextOverflow.ellipsis ,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
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
                                                                    fontSize:
                                                                        16),
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
                                                      margin: EdgeInsets.only(
                                                          top: 6),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 12),
                                                            child: Text(
                                                              getMovieCon
                                                                  .moviesList[
                                                                      index]
                                                                  .originalLanguage
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 12),
                                                            child: Text(
                                                              getMovieCon
                                                                  .moviesList[
                                                                      index]
                                                                  .voteCount
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
                                      )),
                                );
                              },
                            );
                        }),
                      ),
                      Expanded(
                        // height: 200,
                        child: Container(
                          // / height: 20,

                          child: Obx(() {
                            if (searchMoviesController.noData.value == true) {
                              return Center(
                                child: Text("search something in search bar"),
                              );
                            } else if (searchMoviesController.isLoading.value ==
                                true) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return _width > 1000
                                  ? StaggeredGridView.countBuilder(
                                      crossAxisCount: 2,
                                      itemCount: searchMoviesController
                                          .searchList.length,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            searchMoviesController.setMovie(
                                                searchMoviesController
                                                    .searchList[index],
                                                context);
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
                                                        child: image(
                                                            "https://image.tmdb.org/t/p/original/${searchMoviesController.searchList[index].posterPath.toString()}"),
                                                      ),
                                                      Container(
                                                        width: _width / 2 - 120,
                                                        height: 150,
                                                        child: data(_height,
                                                            _width / 2, index),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      staggeredTileBuilder: (index) =>
                                          StaggeredTile.fit(1),
                                    )
                                  : NotificationListener<ScrollNotification>(
                                    child: ListView.builder(
                                      controller: _scrollController,
                                        itemCount: searchMoviesController
                                            .tempList.length,
                                        itemBuilder: (context, index) {
                                          if(index /10 ==0){

                                            return Card(
                                              child: Container(
                                                height: 150,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 150,
                                                          width: 100,
                                                          child: image(
                                                              "https://image.tmdb.org/t/p/original/${searchMoviesController.tempList[index].posterPath.toString()}"),
                                                        ),
                                                        Container(
                                                          width: _width - 110,
                                                          height: 150,
                                                          //color: Colors.red,
                                                          child: data(_height,
                                                              _width, index),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ) ;
                                          }
                                          else

                                          return InkWell(
                                            onTap: () {
                                              searchMoviesController.setMovie(
                                                  searchMoviesController
                                                      .tempList[index],
                                                  context);
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
                                                          child: image(
                                                              "https://image.tmdb.org/t/p/original/${searchMoviesController.tempList[index].posterPath.toString()}"),
                                                        ),
                                                        Container(
                                                          width: _width - 110,
                                                          height: 150,

                                                          child: data(_height,
                                                              _width, index),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                onNotification: (t) {
                                  if (t.metrics.pixels ==
                                      t.metrics.maxScrollExtent) {
                                    searchMoviesController.addRows(10);

                                    return true;
                                  }

                                  return false;
                                }
                                  );
                            }
                          }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget image(String path) {
    return Image.network(
      path,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget data(var _height, _width, index) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: _width - 190,
                margin: EdgeInsets.only(left: 12),
                child: Text(
                  searchMoviesController.tempList[index].originalTitle
                      .toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 12),
                child: Row(
                  children: [
                    Text(
                      searchMoviesController.tempList[index].voteAverage
                          .toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
          margin: EdgeInsets.only(top: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Text(
                  searchMoviesController.tempList[index].originalLanguage
                      .toString(),
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 12),
                child: Text(
                  searchMoviesController.tempList[index].popularity.toString(),
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: _width - 110,
          margin: EdgeInsets.only(left: 12, top: 18),
          child: Text(
            searchMoviesController.tempList[index].overview.toString(),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
          ),
        ),
      ],
    );
  }
}
