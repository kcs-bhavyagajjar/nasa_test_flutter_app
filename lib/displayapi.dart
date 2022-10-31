import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:test_app/Detail.dart';
import 'package:test_app/Model/customermodel.dart';
import 'package:test_app/Model/imagemodel.dart';

class DisplayApi extends StatefulWidget {
  const DisplayApi({Key? key}) : super(key: key);

  @override
  State<DisplayApi> createState() => _DisplayApiState();
}

List<Item> verticalData = [];
List<Datamodeldetail> notes = [];

class _DisplayApiState extends State<DisplayApi> {
  Collection? collection;
  String uri = "https://images-api.nasa.gov/search?q=moon&page=1";
  String nextUrl = "";
  bool _hasNextPage = true;
  late ScrollController _controller;
  late StreamSubscription _streamSubscription;
  bool isLoading = false;
  bool isFirstLoading = false;
  var scroll = ScrollController();
  var preventCall = false;

  // Future checkConnectivity() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } else {
  //     var databaseadd = await NotesDatabase.instance.readAllNotes();
  //     setState(() async {
  //       notes = databaseadd;
  //       isLoading = false;
  //     });
  //   }
  // }

  void onScroll() {
    var position = scroll.position.pixels;
    if (position >= scroll.position.maxScrollExtent - 10) {
      if (!preventCall) {
        _loadMore().then((_) => preventCall = false);
        preventCall = true;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(uri);
    _controller = ScrollController()..addListener(onScroll);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _controller.removeListener(onScroll);
    super.dispose();
  }

  // Future refreshNotes() async {
  //   setState(() => isLoading = true);
  //   for (int i = 0; i <= verticalData.length; i++) {
  //     await NotesDatabase.instance.create(Datamodeldetail(
  //         href: verticalData[i].href,
  //         center: verticalData[i].data[0].center.toString(),
  //         title: verticalData[i].data[0].title,
  //         //image: verticalData[i].links[0].href,
  //         description: verticalData[i].data[0].description));
  //   }
  //   setState(() => isLoading = false);
  // }

  Future _loadMore() async {
    if (_controller.position.extentAfter < 300) {
      setState(() {
        isLoading = true;
      });
      final res = await http.get(Uri.parse(nextUrl));
      if (res.statusCode == 200) {
        final List<Item> fetchedPosts =
            imagemodelFromJson(res.body).collection.items;
        collection = imagemodelFromJson(res.body).collection;
        if (collection?.links.length == 1) {
          nextUrl = collection!.links[0].href;
        } else {
          nextUrl = collection!.links[1].href;
        }
        print("next url:==$nextUrl");
        if (fetchedPosts.isNotEmpty) {
          verticalData.addAll(fetchedPosts);
          //refreshNotes();
          setState(() {
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          _hasNextPage = false;
          Container(
            alignment: Alignment.center,
            child: const Text("No Internet Connection"),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cubit Api Call",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white70,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 6,
        actions: [
          IconButton(
            onPressed: () {
              scrollup();
            },
            icon: const Icon(Icons.arrow_upward),
          ),
          IconButton(
            onPressed: () {
              scrolldown();
            },
            icon: const Icon(Icons.arrow_downward),
          ),
        ],
      ),
      body: isFirstLoading == true
          ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Wait a Second",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: verticalData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: Colors.white70,
                        elevation: 6,
                        child: ListBody(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Details(model: verticalData[index]),
                                      settings: RouteSettings(
                                          arguments: verticalData[index])),
                                );
                              },
                              child: Table(
                                columnWidths: const {
                                  1: FractionColumnWidth(.6)
                                },
                                // columnWidths: const {1: FractionColumnWidth(1)},
                                children: <TableRow>[
                                  TableRow(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(7),
                                          child: Image.network(
                                            height: 100.0,
                                            width: 100.0,
                                            fit: BoxFit.fill,
                                            verticalData[index].links != null &&
                                                    verticalData[index]
                                                        .links
                                                        .isNotEmpty
                                                ? verticalData[index]
                                                    .links
                                                    .first
                                                    .href
                                                    .toString()
                                                : "",
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              if (kDebugMode) {
                                                print(
                                                    "Exception >> ${exception.toString()}");
                                              }
                                              return Image.asset(
                                                  height: 80.0,
                                                  width: 80.0,
                                                  'images/smart-city.png');
                                            },
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(7),
                                        child: Text(
                                          verticalData.isEmpty
                                              ? ""
                                              : verticalData[index]
                                                  .data[0]
                                                  .title,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (isLoading == true)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    color: Colors.blue,
                    child: Container(
                      height: 50.0,
                      alignment: Alignment.center,
                      child: const Text(
                        'You have fetched all of the Data',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                    ),
                  )
              ],
            ),
    );
  }

  Future fetchData(String s) async {
    //checkConnectivity();
    try {
      setState(() {
        isFirstLoading = true;
      });
      final response = await http.get(Uri.parse(s));
      if (response.statusCode == 200) {
        collection = imagemodelFromJson(response.body).collection;
        verticalData.addAll(collection?.items ?? []);
        nextUrl = collection!.links[0].href;
        //refreshNotes();
      }
      // }hah
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong ${err.toString()}');
      }
    }
    setState(() {
      isFirstLoading = false;
    });
  }

  void scrollup() {
    final double start = _controller.position.minScrollExtent;
    _controller.jumpTo(start);
  }

  void scrolldown() {
    final double end = _controller.position.maxScrollExtent;
    _controller.jumpTo(end);
  }
}
