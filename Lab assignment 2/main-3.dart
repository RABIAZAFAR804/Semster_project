
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/game_screen.dart';
import 'screens/results_screen.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const GameScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'results',
          builder: (BuildContext context, GoRouterState state) {
            return const ResultsScreen();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color lightPeach = Color(0xFFFFE5B4);
    const Color darkOrange = Color(0xFFF8961E);
    const Color softOrange = Color(0xFFF9C74F);

    return MaterialApp.router(
      title: 'Number Guessing Game',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: lightPeach,
        textTheme: TextTheme(
          headlineSmall: GoogleFonts.roboto(color: Colors.black),
          titleLarge: GoogleFonts.roboto(color: Colors.black, fontSize: 22),
          bodyMedium: GoogleFonts.roboto(color: Colors.black),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: darkOrange,
          titleTextStyle: GoogleFonts.oswald(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.black54),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: softOrange,
            textStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ),
      ),
      routerConfig: _router,
    );
  }
}
