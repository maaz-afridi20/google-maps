import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonssGoogleMaps extends StatefulWidget {
  const PolygonssGoogleMaps({super.key});

  @override
  State<PolygonssGoogleMaps> createState() => _PolygonssGoogleMapsState();
}

class _PolygonssGoogleMapsState extends State<PolygonssGoogleMaps> {
  CameraPosition initialCamera =
      const CameraPosition(target: LatLng(33.654235, 73.073000), zoom: 13);

  Completer<GoogleMapController> completerController = Completer();

  final Set<Marker> markers = {};
  Set<Polygon> polygonn = HashSet<Polygon>();

  // for the polygon the starting and the ending point should be same.
  List<LatLng> points = const [
    LatLng(33.654235, 73.073000),
    LatLng(33.647326, 72.820175),
    LatLng(33.689531, 72.763160),
    LatLng(33.647326, 72.820175),
    LatLng(34.131452, 72.662334),
    LatLng(33.654235, 73.073000),
  ];

  @override
  void initState() {
    super.initState();
    polygonn.add(
      Polygon(
        polygonId: PolygonId('1'),
        points: points,
        fillColor: Colors.transparent,
        geodesic: true,
        strokeWidth: 4,
        strokeColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polygons in maps'),
      ),
      body: GoogleMap(
        polygons: polygonn,
        initialCameraPosition: initialCamera,
        onMapCreated: (controller) {
          completerController.complete(controller);
        },
      ),
    );
  }
}
