import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:test_app/Detail.dart';
import 'package:test_app/Model/imagemodel.dart';

class DisplayApi extends StatefulWidget {
  const DisplayApi({Key? key}) : super(key: key);

  @override
  State<DisplayApi> createState() => _DisplayApiState();
}

List<Item> verticalData = [];

class _DisplayApiState extends State<DisplayApi> {
  Collection? collection = null;
  String uri = "https://images-api.nasa.gov/search?q=moon&page=1";
  String lasturi = "https://images-api.nasa.gov/search?q=moon&page=101";
  String status = "";
  bool hideui = false;
  String nextUrl = "";
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool isLoadingVertical = false;
  bool _isLoadMoreRunning = false;
  late ScrollController _controller;
  final _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  void checkConnectivity() async {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        setState(() {
          hideui = false;
        });
      } else {
        setState(() {
          hideui = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No internet conection")));
        status = "No Internet connection";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    fetchData(uri);
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  Future _loadMore() async {
    if (_isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
        // Display a progress indicator at the bottom
      });
      // Increase _page by 1
      try {
        final res = await http.get(Uri.parse(lasturi));
        if (kDebugMode) {
          print(nextUrl);
        }
        final List<Item> fetchedPosts =
            imagemodelFromJson(res.body).collection.items;
        collection = imagemodelFromJson(res.body).collection;
        if (collection?.links.length == 1) {
          nextUrl = collection!.links[0].href;
        } else {
          nextUrl = collection!.links[1].href;
        }
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            verticalData.addAll(fetchedPosts);
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
          setState(() {
            _hasNextPage = false;
          });
          print('Something went wrong!');
        }
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    } else {
      setState(() {
        Container(
          alignment: Alignment.center,
          child: const Text("No Internet Connection"),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cubit Api Call"),
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
      body: hideui
          ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(height: 80.0, width: 80.0, "images/no-wifi.png"),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "No Internet Connection",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _controller,
                    itemCount: verticalData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white54,
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
                                            height: 82.0,
                                            width: 80.0,
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
                                      )
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
                if (_isLoadMoreRunning == true)
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
                      alignment: Alignment.center,
                      child: const Text(
                        'You have fetched all of the Data',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
              ],
            ),
    );
  }

  void fetchData(String s) async {
    // User defined class
    try {
      // if (s.isNotEmpty) {
      // print("url : $s");
      setState(() {
        _isFirstLoadRunning = true;
      });
      final response = await http.get(Uri.parse(s));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response);
        }
        setState(() {
          collection = imagemodelFromJson(response.body).collection;
          verticalData.addAll(collection?.items ?? []);

          // Nexturl = collection!.links[0].href;
        });
      }
      // }
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong ${err.toString()}');
      }
    }
    setState(() {
      _isFirstLoadRunning = false;
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
