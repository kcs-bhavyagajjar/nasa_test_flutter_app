import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:test_app/Model/imagemodel.dart';
import 'package:test_app/Model/itemlistmodel.dart';
import 'package:video_player/video_player.dart';

class Details extends StatefulWidget {
  Item? model;

  Details({Key? key, this.model}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late VideoPlayerController _controller;
  List<String> jpgList = [];
  List<String> list = ['All', 'Small', 'Medium', 'Large'];
  List<String> nbj = [];
  List<String> imagesBySize = [];
  late String dropdownValue = list.first;
  bool isLoading = false;

  Future<void> fetchData(String url) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(url));
    print("url : $response");
    nbj = listmodelFromJson(response.body);
    if (response.statusCode == 200) {
      setState(() {
        jpgList = nbj.where((i) => i.endsWith('jpg')).toList();
        if (kDebugMode) {
          print(nbj);
        }
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    String url = widget.model!.href;
    fetchData(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)?.settings.arguments as Item;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 6,
        title: Text(
          model.data[0].title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading == true
          ? Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: (model.links.isNotEmpty)
                      ? _sliderNotification()
                      : Container(
                          padding: const EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 180,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              end: Alignment(0.0, -1),
                              begin: Alignment(0.0, 1),
                              colors: [
                                Color(0xFF194f81),
                                Color(0xFF3b4783),
                                Color(0xFF594085),
                              ],
                            ),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("images/dashboardbanner.png"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                  child: Text(
                    model.data[0].title,
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(12),
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${model.data[0].center}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          Jiffy("${model.data[0].dateCreated}").yMMMMd,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          maxLines: 5,
                          model.data[0].description,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 15.0),
                      child: Text(
                        "Other Images",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, top: 15.0),
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        iconSize: 30,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(fontSize: 20)),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                            imagesBySize = jpgList
                                    .where(
                                        (i) => i.contains(value.toLowerCase()))
                                    .toList() ??
                                [];
                            //jpgList = nbj.where((i) => i.contains(value.toLowerCase())).toList();
                            print(jpgList);
                            // Gridview(jpglist,value);
                          });
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(15.0),
                      itemCount: dropdownValue == 'All'
                          ? jpgList.length
                          : imagesBySize.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 20.0,
                              mainAxisSpacing: 20.0),
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'images/smart-city.png',
                            image: dropdownValue == 'All'
                                ? jpgList[index]
                                : imagesBySize[index],
                            fit: BoxFit.fill,
                            height: 180,
                            imageErrorBuilder: (BuildContext? context,
                                Object? y, StackTrace? z) {
                              return const Image(
                                image: AssetImage('images/smart-city.png'),
                                height: 180,
                                fit: BoxFit.fill,
                              );
                            },
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 60.0,
                )
              ],
            )),
    );
  }

  Widget _sliderNotification() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
          height: 180,
          child: Swiper(
            loop: false,
            pagination: const FractionPaginationBuilder(),
            itemBuilder: (BuildContext context, int index) {
              String imgPath = "";
              imgPath =
                  dropdownValue == 'All' ? jpgList[index] : imagesBySize[index];
              return Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'images/smart-city.png',
                    image: imgPath,
                    fit: BoxFit.fill,
                    height: 180,
                    // imageErrorBuilder:
                    //     (BuildContext? context, Object? y, StackTrace? z) {
                    //   return const Image(
                    //     image: AssetImage('images/smart-city.png'),
                    //     height: 180,
                    //     fit: BoxFit.fill,
                    //   );
                    // },
                  ));
            },
            itemCount:
                dropdownValue == 'All' ? jpgList.length : imagesBySize.length,
            autoplay: (jpgList.length) > 1 ? true : false,
          )),
    );
  }
}
