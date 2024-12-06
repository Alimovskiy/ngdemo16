import 'package:flutter/material.dart';
import 'package:ngdemo16/models/collection_model.dart';
import 'package:ngdemo16/models/photo_model.dart';
import 'package:ngdemo16/models/search_photos_res.dart';
import 'package:ngdemo16/service/http_service.dart';
import 'package:ngdemo16/service/log_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? _pageController;
  int _currentTap = 0;

  apiSearchPhotos() async {
    var response = await Network.GET(
        Network.API_SEARCH_PHOTOS, Network.paramsSearchPhotos("office", 1));
    SearchPhotosRes searchPhotosRes = Network.parseSearchPhotos(response!);
    LogService.i(searchPhotosRes.results.length.toString());
  }

  apiCollectionList() async {
    var response = await Network.GET(
        Network.API_COLLECTIONS, Network.paramsCollections(1));
    List<Collection> collections = Network.parseCollections(response!);
    LogService.i(collections.length.toString());
  }

  apiCollectionPhotos() async {
    var response = await Network.GET(
        Network.API_COLLECTIONS_PHOTOS.replaceFirst(":id", "sPgfgvR6DMo"),
        Network.paramsCollectionsPhotos(1));
    List<Photo> photos = Network.parseCollectionsPhotos(response!);
    LogService.i(photos.length.toString());
  }

  @override
  void initState() {
    super.initState();
    apiCollectionPhotos();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Center(child: Text(
              "UNSPLASH", style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold))),
      backgroundColor: Colors.black,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.pix_sharp),
        color: Colors.white,
      ),
    ),
      body: PageView(
        controller: _pageController,
        children: [
          Center(
            child: Text(
              "Search photos",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              "Collection list",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTap = index;
          });
        },
      ),
    );
  }
}