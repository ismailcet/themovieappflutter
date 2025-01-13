import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themovieapp/pages/splash_page.dart';
import 'package:themovieapp/provider/watchlist_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => WatchlistProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: const Color(0xFF1E1E1E),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
