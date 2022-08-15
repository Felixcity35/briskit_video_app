// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:loading_animations/loading_animations.dart';

import '../../Helpers/Constants/myColors.dart';
import 'search_list.dart';
import 'search_movie_list.dart';
import 'search_repo.dart';

class SearchHome extends StatefulWidget {
  const SearchHome({Key? key}) : super(key: key);

  @override
  MoviesAppHomeState createState() => MoviesAppHomeState();
}

class MoviesAppHomeState extends State<SearchHome> {
  final searchTextController = TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      debounceDuration: Duration.zero,
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        if (connectivity == ConnectivityResult.none) {
          return Scaffold(
            backgroundColor: greyBG,
            appBar: AppBar(
              title: const Text('Search'),
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
            body: const Center(child: Text('NO INTERNET CONNECTION')),
          );
        }
        return child;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Search Screen'),
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
          body: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(children: <Widget>[
                  Flexible(
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        setState(() {
                          searchText = searchTextController.text;
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        });
                      },
                      controller: searchTextController,
                      decoration: InputDecoration(
                        focusColor: Colors.black,
                        labelText: "Search for movies",
                        hintText: "type here to start searching",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          tooltip: 'Go',
                          onPressed: () {
                            setState(() {
                              searchText = searchTextController.text;
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                            });
                          },
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              if (searchText.isNotEmpty)
                FutureBuilder<List<Movie>>(
                    future: searchMovies(searchText.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return Expanded(
                            child: MovieList(movies: snapshot.data!.toList()));
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return loadingIndicator();
                    }),
            ],
          )),
    );
  }

  Widget loadingIndicator() {
    return Container(
      alignment: Alignment.center,
      child: LoadingBouncingGrid.circle(
        backgroundColor: Colors.blue,
        size: 60.0,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
}
