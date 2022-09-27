import 'dart:math';

import 'package:flutter/material.dart';
import '../models/album.dart';
import '../models/photo.dart';
import '../pages/album_page.dart';

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
          List<Photo> albumPhotos = getAlbumPhotos(album?.id);
          Route route = MaterialPageRoute(
            builder: ((context) => AlbumPage(
                  album: album!,
                  albumPhotos: albumPhotos,
                )),
          );
          Navigator.push(context, route);
        },
      ),
    );
  }

  List<Photo> getAlbumPhotos(int? albumId) {
    return photos.where((element) => element.albumId == albumId).toList();
  }
}
