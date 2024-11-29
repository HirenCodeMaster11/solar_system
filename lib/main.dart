import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_system/Provider/provider.dart';

import 'View/home page/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SolarProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: SolarSystemPage(),
      ),
    );
  }
}