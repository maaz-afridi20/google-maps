import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUsrLoc2 extends StatefulWidget {
  const GetUsrLoc2({super.key});

  @override
  State<GetUsrLoc2> createState() => _GetUsrLoc2State();
}

class _GetUsrLoc2State extends State<GetUsrLoc2> {
  CameraPosition initialCamera =
      const CameraPosition(target: LatLng(33.6844, 73.0479), zoom: 14);

  Completer<GoogleMapController> completerMapController = Completer();

  List<Marker> mrksrssListy = [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(33.6844, 73.0479),
    ),
    Marker(
      markerId: MarkerId("2"),
      position: LatLng(33.7383, 73.0565),
    ),
  ];

  GoogleMapController? myGoogleController;

  Future<Position> getUsrLocccc() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Some Error',
          ),
        ),
      );
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Getting User Location'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          completerMapController.complete(controller);
        },
        markers: Set<Marker>.of(mrksrssListy),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: initialCamera,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUsrLocccc().then((value) async {
            myGoogleController = await completerMapController.future;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                value.latitude.toString() + " " + value.longitude.toString(),
              )),
            );
            mrksrssListy.add(
              Marker(
                markerId: const MarkerId("3"),
                position: LatLng(value.longitude, value.latitude),
                infoWindow: const InfoWindow(
                  title: 'Nathiya Gali',
                ),
              ),
            );
            CameraPosition newPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude), zoom: 14);

            setState(() {
              myGoogleController!.animateCamera(
                CameraUpdate.newCameraPosition(newPosition),
              );
            });
          });
        },
        child: const Icon(Icons.change_circle),
      ),
    );
  }
}
