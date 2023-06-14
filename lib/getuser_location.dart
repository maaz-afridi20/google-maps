import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUsrLocation extends StatefulWidget {
  const GetUsrLocation({super.key});

  @override
  State<GetUsrLocation> createState() => _GetUsrLocationState();
}

class _GetUsrLocationState extends State<GetUsrLocation> {
  CameraPosition initialCameraPos =
      const CameraPosition(target: LatLng(33.7295, 73.0372), zoom: 14);

  final List<Marker> mrkrsList = [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(33.7295, 73.0372),
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen), // this will change the color of the icon.
      infoWindow: InfoWindow(title: "title of marker"),
    ),
  ];

  GoogleMapController? myGoogleController;

  final Completer<GoogleMapController> mapController = Completer();

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$error')));
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Getting UserLocation'),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPos,
        markers: Set<Marker>.of(mrkrsList),
        onMapCreated: (GoogleMapController controller) {
          mapController.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getUserCurrentLocation().then((value) async {
            print(value.latitude.toString() + " " + value.longitude.toString());
            mrkrsList.add(
              Marker(
                markerId: const MarkerId("2"),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: const InfoWindow(title: 'New Curreent Locatino'),
              ),
            );
            CameraPosition campos = CameraPosition(
                target: LatLng(value.latitude, value.longitude), zoom: 14);

            myGoogleController = await mapController.future;

            myGoogleController!
                .animateCamera(CameraUpdate.newCameraPosition(campos));
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
