import 'package:flutter/material.dart';
import 'package:google_mapss/get_usr_loc2.dart';
import 'package:google_mapss/getuser_location.dart';
import 'package:google_mapss/google_search_places_api/search_places.dart';

import 'anotherdependency.dart';
import 'custom_markers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: CustomMarkerss(),
    );
  }
}
