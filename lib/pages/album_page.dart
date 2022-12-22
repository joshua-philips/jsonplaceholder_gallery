import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/album.dart';
import '../models/photo.dart';
import '../services/fetch.dart';

class AlbumPage extends ConsumerWidget {
  final Album album;
  const AlbumPage({super.key, required this.album});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ScrollController();
    final photosAsync = ref.watch(fetchPhotosProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(album.title ?? ""),
      ),
      body: photosAsync.when(
        data: (data) => Center(
          child: Scrollbar(
            controller: scrollController,
            child: RefreshIndicator(
              onRefresh: () async {
                ref.refresh(fetchPhotosProvider.future);
              },
              child: GridView.builder(
                controller: scrollController,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                itemCount: getAlbumPhotos(album.id, data).length,
                itemBuilder: (context, index) => Container(
                  height: 150,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://picsum.photos/${Random.secure().nextInt(601)}"),
                      fit: BoxFit.cover,
                      opacity: 0.7,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
        loading: () => const LinearProgressIndicator(),
      ),
    );
  }
}

List<Photo> getAlbumPhotos(int? albumId, List<Photo> photos) {
  return photos.where((element) => element.albumId == albumId).toList();
}
