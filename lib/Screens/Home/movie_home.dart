import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/Helpers/Constants/MyLists.dart';
import 'package:movies_app/Helpers/Constants/myColors.dart';
import 'package:movies_app/Screens/Details/details.dart';

class MovieHome extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<MovieHome> {
  // List<dynamic> myList = Get.arguments;
  List<dynamic> myList = top250Movies;

  Widget ShowContainer() {
    return Expanded(
      child: ListView.separated(
        itemCount: myList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              await Get.to(() => Details(),
                  arguments: myList[index],
                  duration: Duration(milliseconds: 700),
                  transition: Transition.leftToRightWithFade);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 185,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Image(
                        image: NetworkImage(myList[index].Image),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            myList[index].Title,
                            style: TextStyle(fontSize: 20, color: white),
                          ),
                          Text(
                            myList[index].Year,
                            style: TextStyle(fontSize: 18, color: white),
                          ),
                          Text(
                            myList[index].Crew,
                            style: TextStyle(fontSize: 15, color: white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star,
                                color: yellow,
                                size: 23,
                              ),
                              myList[index].IMDbRating.toString().isNotEmpty
                                  ? Text(
                                      ' ' + myList[index].IMDbRating,
                                      style:
                                          TextStyle(fontSize: 18, color: white),
                                    )
                                  : Text(
                                      ' TBA',
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 16,
                                      ),
                                    ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.white54,
            indent: 8,
            endIndent: 8,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.deepPurple, Colors.pink],
            ),
          ),
        ),
      ),
      backgroundColor: greyBG,
      body: Column(
        children: [
          ShowContainer(),
        ],
      ),
    );
  }
}
