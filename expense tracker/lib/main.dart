import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project4/expenses.dart';

var kcolorscheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

var kdarkcolorscheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])  // it lock device to be in landscape when we rotate it.
      .then((value) => {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kdarkcolorscheme,
      cardTheme: const CardTheme().copyWith(
          color: kdarkcolorscheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 19)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kdarkcolorscheme.primaryContainer,
              foregroundColor: kdarkcolorscheme.onPrimaryContainer)),
    ),
    theme: ThemeData().copyWith(
        colorScheme: kcolorscheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kcolorscheme.onPrimaryContainer,
            foregroundColor: kcolorscheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
            color: kcolorscheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 19)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kcolorscheme.primaryContainer)),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
                color: kcolorscheme.secondary))),
    home: const Expenses(),
    debugShowCheckedModeBanner: false,
  ));
}
          
          );

