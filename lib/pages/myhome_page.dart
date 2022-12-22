import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/my_theme.dart';
import '../services/fetch.dart';
import '../widgets/album_card.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ScrollController();
    final albumsAsync = ref.watch(fetchAlbumsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.lexendDeca(),
        ),
      ),
      body: Center(
        child: albumsAsync.when(
          data: (data) => Scrollbar(
            controller: scrollController,
            child: RefreshIndicator(
              onRefresh: () async {
                ref.refresh(fetchAlbumsProvider.future);
              },
              child: ListView.builder(
                controller: scrollController,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return AlbumCard(album: data[index]);
                },
              ),
            ),
          ),
          error: (err, stack) => Center(child: Text('Error: $err')),
          loading: () => const CircularProgressIndicator(),
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
