import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test_app/Model/imagemodel.dart';

import 'Detail.dart';
import 'home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: '',
        home: Home());
    // home: MyHomePage(title: "title"));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // We will fetch data from this Rest api
  final String _baseUrl = "http://images-api.nasa.gov/search?q=moon&page=1";

  // At the beginning, we fetch the first 20 posts
  int _page = 1;

  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int _limit = 100;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  // List _posts = [];
  List<Item> _posts = [];
  Collection? collection = null;

  // This function will be called when the app launches (see the initState function)
  void _firstLoad(String s) async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await get(Uri.parse(s));
      setState(() {
        // _posts = json.decode(res.body);
        collection = Imagemodel.fromJson(jsonDecode(res.body)).collection;
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong ${err.toString()}');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1
      try {
        final res =
            // await get(Uri.parse(_baseUrl));
            await get(Uri.parse("$_baseUrl&page=$_page"));

        // final List fetchedPosts = json.decode(res.body);
        List<Item> fetchedPosts =
            Imagemodel.fromJson(jsonDecode(res.body)).collection.items;
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad(_baseUrl);
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: _isFirstLoadRunning
          ? Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _posts.length,
                    itemBuilder: (_, index) => Card(
                      elevation: 4,
                      child: ListBody(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Details(),
                                    settings: RouteSettings(
                                        arguments: _posts[index])),
                              );
                            },
                            child: Table(
                              columnWidths: const {1: FlexColumnWidth(1.8)},
                              children: [
                                TableRow(children: [
                                  InkWell(
                                    child: SizedBox(
                                        width: 50.0,
                                        height: 100.0,
                                        child: Image.network(
                                          _posts[index].links != null &&
                                                  _posts[index].links.isNotEmpty
                                              ? _posts[index]
                                                  .links
                                                  .first
                                                  .href
                                                  .toString()
                                              : "",
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            print(
                                                "Exception >> ${exception.toString()}");
                                            return Image.asset(
                                                'lib/assets/images/product.jpg');
                                          },
                                        )),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.all(6),
                                    width: 50.0,
                                    height: 100.0,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            _posts[index].data != null &&
                                                    _posts[index].data.length >
                                                        0
                                                ? _posts[index]
                                                    .data
                                                    .first
                                                    .title
                                                    .toString()
                                                : "",
                                            maxLines: 2,
                                            //style: TextStyles.homeTitleText(context),
                                          ),
                                          Text(
                                            _posts[index].data != null &&
                                                    _posts[index]
                                                        .data
                                                        .isNotEmpty
                                                ? _posts[index]
                                                    .data
                                                    .first
                                                    .description
                                                    .toString()
                                                : "",
                                            maxLines: 3,
                                            // style:
                                            //TextStyles.homeDescriptionText(context),
                                          ),
                                        ]),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // when the _loadMore function is running
                if (_isLoadMoreRunning == true)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                  ),

                // When nothing else to load
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('You have fetched all of the content'),
                    ),
                  ),
              ],
            ),
    );
  }
}

// setState(() {
//   _isLoadMoreRunning = true; // Display a progress indicator at the bottom
// });
// verticalData.addAll(collection?.items ?? []);
//
// if (collection?.links.length == 2) {
//   //this is next link
//   print("next url :------${collection?.links[1].href ?? ""}");
//   fetchData(collection?.links[1].href ?? "");
// } else if (collection?.links.length == 1) {
//   //this is first time of next link
//   print("next url :------${collection?.links[0].href ?? ""}");
//   fetchData(collection?.links[0].href ?? "");
// }
// print(
//     "${collection?.items.length} added in list : total items  : ${verticalData.length}");
//
// setState(() {
//   verticalData;
// });
//
// setState(() {
//   if (_isLoadMoreRunning == true)
//     const Padding(
//       padding: EdgeInsets.only(top: 10, bottom: 40),
//       child: CircularProgressIndicator(),
//     );
//   isLoadingVertical = false;
// });
