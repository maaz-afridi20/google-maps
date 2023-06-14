import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonsLines extends StatefulWidget {
  const PolygonsLines({super.key});

  @override
  State<PolygonsLines> createState() => _PolygonsLinesState();
}

class _PolygonsLinesState extends State<PolygonsLines> {
  Completer<GoogleMapController> completerGoogleController = Completer();
  late GoogleMapController controller;

  CameraPosition initial =
      const CameraPosition(target: LatLng(33.738045, 73.084488), zoom: 13);

  final Set<Marker> markers = {};
  final Set<Polyline> polylines = {};

  List<LatLng> latlng = [
    LatLng(33.738045, 73.084488),
    LatLng(33.6844, 73.0479),
    LatLng(33.6845, 73.0861),
    LatLng(33.7215, 73.0765),
    LatLng(33.6928, 73.0551),
    LatLng(33.6908, 73.0163),
    LatLng(33.7234, 73.0602),
    LatLng(33.567997728, 72.635997456),
  ];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < latlng.length; i++) {
      markers.add(
        Marker(
            markerId: MarkerId(
              i.toString(),
            ),
            position: latlng[i],
            infoWindow: const InfoWindow(
              title: 'Cooll',
              snippet: '5 Star location',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRose)),
      );
      setState(() {
        polylines.add(
          Polyline(
            polylineId: PolylineId('1'),
            points: latlng,
            color: Colors.lightGreen,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PolyLines'),
      ),
      body: GoogleMap(
        markers: markers,
        initialCameraPosition: initial,
        onMapCreated: (controller) {
          completerGoogleController.complete(controller);
        },
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        polylines: Set<Polyline>.of(polylines),
      ),
    );
  }
}
