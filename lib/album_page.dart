import 'package:flutter/material.dart';
import 'models/album.dart';
import 'models/photo.dart';

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
          itemCount: albumPhotos.length,
          itemBuilder: (context, index) => Card(
            child: Container(
              height: 150,
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
      ),
    );
  }
}
