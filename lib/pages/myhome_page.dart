import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/album.dart';
import '../models/photo.dart';
import '../providers/my_theme.dart';
import '../services/fetch.dart';
import '../widgets/album_card.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  List<Photo> photos = [];
  late Future<List<Album>> fetch;

  @override
  void initState() {
    super.initState();
    fetch = fetchAlbums();
  }

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
        title: Text(
          widget.title,
          style: GoogleFonts.lexendDeca(),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: fetch,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                dev.log(snapshot.data!.length.toString());
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
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'John Doe',
                style: GoogleFonts.lexendDeca(),
              ),
              accountEmail: const Text('johndoe@example.com'),
            ),
            SwitchListTile(
              value: ref.watch(myThemeProvider) == MyThemeMode.light
                  ? false
                  : true,
              title: const Text('Mode'),
              onChanged: (value) {
                ref.read(myThemeProvider.notifier).toggle();
              },
            ),
            const AboutListTile(
              applicationName: 'JSON Placeholder Album',
              icon: Icon(Icons.info),
              applicationVersion: '1.0.0',
              child: Text('JSON Placeholder Album'),
            )
          ],
        ),
      ),
    );
  }
}
