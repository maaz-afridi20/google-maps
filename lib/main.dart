import 'package:flutter/material.dart';
import 'package:google_mapss/custom_window_info/cstm_window_info.dart';
import 'package:google_mapss/getuser_location.dart';
import 'package:google_mapss/polygons/polygons_lines.dart';
import 'package:google_mapss/polygons/polygonss.dart';

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
      home: PolygonsLines(),
    );
  }
}
