import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Another extends StatefulWidget {
  const Another({super.key});

  @override
  State<Another> createState() => _AnotherState();
}

class _AnotherState extends State<Another> {
  CameraPosition initialCameraPos =
      const CameraPosition(target: LatLng(33.7295, 73.0372), zoom: 14);

  Completer<GoogleMapController> myconti = Completer();

  GoogleMapController? mapController;

  List<Marker> markersList = [];
  List<Marker> addingMarkers = const [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(33.7295, 73.0372),
      infoWindow: InfoWindow(
        title: "Faisal Masjid",
      ),
    ),
    Marker(
      markerId: MarkerId("2"),
      position: LatLng(33.527486, 71.573128),
      infoWindow: InfoWindow(
        title: "Razgir Banda",
      ),
    ),
  ];

  @override
  void initState() {
    markersList.addAll(addingMarkers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Screen'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          myconti.complete(controller);
        },
        markers: Set<Marker>.from(addingMarkers),
        initialCameraPosition: initialCameraPos,
        compassEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            mapController!.animateCamera(
              // this will change the camera position to new place
              // where we have give the latlang,
              CameraUpdate.newCameraPosition(
                const CameraPosition(
                    target: LatLng(25.240460, 51.490860), zoom: 14),
              ),
            );
          });
        },
        child: const Icon(Icons.charging_station),
      ),
    );
  }
}
