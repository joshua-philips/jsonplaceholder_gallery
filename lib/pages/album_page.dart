import 'package:flutter/material.dart';
import '../models/album.dart';
import '../models/photo.dart';

class AlbumPage extends StatelessWidget {
  final Album album;
  final List<Photo> albumPhotos;
  const AlbumPage({super.key, required this.album, required this.albumPhotos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title ?? ""),
      ),
      body: Scrollbar(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          itemCount: albumPhotos.length,
          itemBuilder: (context, index) => Container(
            height: 150,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: NetworkImage(albumPhotos[index].thumbnailUrl!),
                fit: BoxFit.cover,
                opacity: 0.7,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
