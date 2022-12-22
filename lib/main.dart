import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/mytheme_data.dart';
import 'pages/myhome_page.dart';
import 'providers/my_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MyThemeMode myTheme = ref.watch(myThemeProvider);

    return MaterialApp(
      title: 'Placeholder Album',
      debugShowCheckedModeBanner: false,
      themeMode: myTheme == MyThemeMode.dark ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const MyHomePage(title: 'Placeholder Album'),
    );
  }
}
