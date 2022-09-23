import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jsonplaceholder_gallery/models/album.dart';
import 'package:jsonplaceholder_gallery/models/photo.dart';
import 'package:jsonplaceholder_gallery/services/fetch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Placeholder Album',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Placeholder Album'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Photo> photos = [];

  Future<List<Album>> fetchAlbums() async {
    List<Album> albums = [];
    List<dynamic> data =
        await Fetch().fetchList("https://jsonplaceholder.typicode.com/albums");
    for (var element in data) {
      albums.add(Album.fromJson(element));
    }
    await fetchPhotos();
    return albums;
  }

  Future fetchPhotos() async {
    List<dynamic> data =
        await Fetch().fetchList("https://jsonplaceholder.typicode.com/photos");
    for (var element in data) {
      photos.add(Photo.fromJson(element));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchAlbums(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Scrollbar(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return AlbumCard(
                        album: snapshot.data![index],
                        photos: photos,
                      );
                    },
                  ),
                );
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class AlbumCard extends StatelessWidget {
  final List<Photo> photos;
  final Album? album;
  const AlbumCard({super.key, this.album, required this.photos});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.all(12),
      child: InkWell(
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: NetworkImage(
                  "https://picsum.photos/${Random.secure().nextInt(601)}"),
              fit: BoxFit.cover,
              opacity: 0.7,
            ),
          ),
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(12),
            child: Text(
              album?.title ?? "Some Text",
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        onTap: () {
          List<Photo> photos = getAlbumPhotos(album?.id);
        },
      ),
    );
  }

  List<Photo> getAlbumPhotos(int? albumId) {
    return photos.where((element) => element.albumId == albumId).toList();
  }
}
