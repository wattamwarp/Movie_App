import 'package:flutter/material.dart';
import 'package:flutter_app_movie/Controller/MovieDetailController.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';

class MovieDetail extends StatefulWidget {
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  MovieDetailController _movieDetailController =
      Get.put(MovieDetailController());

  @override
  void initState() {
    // TODO: implement initState
    _movieDetailController.getMovieData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (_movieDetailController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return Container(
              color: Color(0xfffaf8f7),
              child:
              _width <700 ?mobile(_width, _height):
              UniversalPlatform.isWeb ?Row(

       children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: _height,

                      child: image("https://image.tmdb.org/t/p/original${_movieDetailController.posterPath.toString()}"),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      height: _height,
                      child: data(_width,_height),
                    ),
                  ),
                ],
            ) :mobile(_width, _height)

            );
        }),
      ),
    );
  }

  Widget mobile(var _width, _height){
    return Column(
      children: [
        Container(
          width: _width,
          height: _height * 0.60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Stack(
            children: [
              Container(
                width: _width,
                height: _height * 0.60,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  child: image("https://image.tmdb.org/t/p/original${_movieDetailController.posterPath.toString()}"),
                ),
              ),
              Container(
                child: Container(
                  width: _width,
                  height: 50,
                  //color: Colors.black38,
                  child:UniversalPlatform.isAndroid || UniversalPlatform.isIOS ? Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black38,
                              size: 30,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        width: _width - 100,
                        child: Center(
                          child: Text(
                            _movieDetailController
                                .originalTitle.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ):Container(),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: _width,
          height: _height * 0.40 - 25,
          child: data(_width,_height),
        )
      ],
    );
  }

  Widget image(String path){
    return Image.network(
      path,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context,
          Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget data(var _width, _height){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top:UniversalPlatform.isWeb?30: 8, left: 8, right: 8),
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.only(top: 8,left: 8,right: 8),
              child: Row(
                children: [
                  Container(
                    height: 28,
                    width: 110,
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.all(
                            Radius.circular(20))),
                    child: Center(
                      child: Text(
                        "PREMERE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    height: 28,
                    width: 140,
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.all(
                            Radius.circular(20))),
                    child: Center(
                      child: Text(
                        "Streaming Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: UniversalPlatform.isWeb ?MainAxisAlignment.start:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        height: 50,
                        width: 160,
                        decoration: BoxDecoration(
                          //color: Colors.blueGrey,
                            borderRadius: BorderRadius.all(
                                Radius.circular(8))),
                        child: Center(
                          child: Text(
                            "Rent 149",
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        height: 50,
                        width: 160,
                        decoration: BoxDecoration(
                          //color: Colors.blueGrey,
                            borderRadius: BorderRadius.all(
                                Radius.circular(8))),
                        child: Center(
                          child: Text(
                            "Buy 699",
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8, top: 8),
              width: _width - 16,
              child: Text(
                _movieDetailController.originalTitle.value
                    .toString(),
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 12, top: 4),
              child: Row(
                children: [
                  Text(
                    _movieDetailController
                        .originalLanguage.value
                        .toString() +
                        ", +2",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      //width: 200,
                      margin: EdgeInsets.only(left: 18),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: _movieDetailController
        .releaseDate.value.length >=10? Text(
                          "Release Date: " +
                              _movieDetailController
                                  .releaseDate.value
                                  .substring(0,10)
                                  .toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ) :Container(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12, left: 8),
              child: Text(
                _movieDetailController.overview.value
                    .toString(),
                style: TextStyle(
                  //fontWeight: FontWeight.bold
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
