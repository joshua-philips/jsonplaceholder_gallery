import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class MyTheme {
  final MyThemeMode myThemeMode;

  const MyTheme({required this.myThemeMode});

  MyTheme copyWith({MyThemeMode? myThemeMode}) {
    return MyTheme(
      myThemeMode: myThemeMode ?? this.myThemeMode,
    );
  }
}

enum MyThemeMode { light, dark }

class MyThemeNotifier extends StateNotifier<MyThemeMode> {
  MyThemeNotifier() : super(MyThemeMode.light);

  void toggle() {
    state = state == MyThemeMode.light ? MyThemeMode.dark : MyThemeMode.light;
  }
}

final myThemeProvider =
    StateNotifierProvider<MyThemeNotifier, MyThemeMode>((ref) {
  return MyThemeNotifier();
});
