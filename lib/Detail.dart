import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/Model/imagemodel.dart';

class Details extends StatefulWidget {
  // Item? model;

  Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

ItemLink? itemlink;

class _DetailsState extends State<Details> {
  var Itemlink;

  Future<void> fetchTData(String s) async {
    if (s.isNotEmpty) {
      print("url : $s");
      final response = await http.get(Uri.parse(s));

      if (response.statusCode == 200) {
        // setState(() {
        Itemlink = imagemodelFromJson(response.body).collection.items[0].href;
        getFileExtension(Itemlink);
        // });
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    }
  }

  @override
  void initState() {
    fetchTData(url);
    super.initState();
  }

  String url =
      "https://images-assets.nasa.gov/audio/Ep114_Value of the Moon/collection.json";

  String getFileExtension(String fileName) {
    return fileName.substring(fileName.lastIndexOf('.'));
  }

  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)?.settings.arguments as Item;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("${model.data[0].title}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: (model.links.isNotEmpty && model.links.length > 0)
                  ? _sliderNotification(model)
                  : Container(
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
                              image: AssetImage("images/dashboardbanner.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                "${model.data[0].title}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                "Center:- ${model.data[0].center}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                "Description:- ${model.data[0].description}",
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sliderNotification(Item model) {
    return Container(
      child: SizedBox(
          height: 180,
          child: Swiper(
            loop: false,
            pagination: const SwiperPagination(),
            itemBuilder: (BuildContext context, int index) {
              String imgpath = "";
              imgpath = getFileExtension(Itemlink) ?? "";
              return Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      end: Alignment(0.0, -1),
                      begin: Alignment(0.0, 1.5),
                      colors: [
                        Color(0xFF085280),
                        /*Color(0xFF304982),*/
                        Color(0xFF613e86),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: imgpath.isNotEmpty
                              ? FadeInImage.assetNetwork(
                                  placeholder: 'images/smart-city.png',
                                  image: imgpath,
                                  fit: BoxFit.fill,
                                  height: 180,
                                  imageErrorBuilder: (BuildContext? context,
                                      Object? y, StackTrace? z) {
                                    return const Image(
                                      image:
                                          AssetImage('images/smart-city.png'),
                                      height: 180,
                                      fit: BoxFit.fill,
                                    );
                                  },
                                )
                              : const Text(
                                  "hello",
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ))
                    ],
                  ),
                ),
              );
            },
            itemCount: model.links.length,
            autoplay: (model.links.length) > 1 ? true : false,
          )),
    );
  }
}
