import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/album.dart';
import '../models/photo.dart';

class Fetch {
  Future<List<dynamic>> fetchList(String url) async {
    final Response response = await Dio().get(url);
    return response.data;
  }
}

final fetchProvider = Provider<Fetch>((ref) {
  return Fetch();
});

final fetchAlbumsProvider =
    FutureProvider.autoDispose<List<Album>>((ref) async {
  List<Album> albums = [];
  List<dynamic> results = await ref
      .read(fetchProvider)
      .fetchList("https://jsonplaceholder.typicode.com/albums");

  for (var element in results) {
    albums.add(Album.fromJson(element));
  }
  albums.shuffle();

  ref.keepAlive();
  return albums;
});

final fetchPhotosProvider =
    FutureProvider.autoDispose<List<Photo>>((ref) async {
  List<Photo> photos = [];
  List<dynamic> results = await ref
      .read(fetchProvider)
      .fetchList("https://jsonplaceholder.typicode.com/photos");

  for (var element in results) {
    photos.add(Photo.fromJson(element));
  }
  photos.shuffle();

  ref.keepAlive();
  return photos;
});
