import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> myController = Completer();
  GoogleMapController? newController;

  void onMapCreated(GoogleMapController googleMapController) {
    newController = googleMapController;
  }

  List<Marker> myMarkers = [];
  final List<Marker> _list = const [
    // we can also use multiple markers.
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(33.7295, 73.0372),
      infoWindow: InfoWindow(
        // this is use for showing some
        // text when my marker is tapped.
        title: 'My Position(Faisal Masjid)',
      ),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(33.527486, 71.573128),
      infoWindow: InfoWindow(
        title: 'Razgir Banda',
      ),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(27.350610, 68.520070),
      infoWindow: InfoWindow(
        title: 'Gumbat',
      ),
    ),
    Marker(
      markerId: MarkerId('4'),
      position: LatLng(33.523640, 71.557040),
      infoWindow: InfoWindow(
        title: 'Billitang',
      ),
    ),
    Marker(
      markerId: MarkerId('5'),
      position: LatLng(25.240460, 51.490860),
      infoWindow: InfoWindow(
        title: 'Doha',
      ),
    ),
  ]; // in this list we will add the markers that  we added

  static const CameraPosition KGooglePlex =
      CameraPosition(target: LatLng(33.7295, 73.0372), zoom: 14);

  @override
  void initState() {
    myMarkers.addAll(_list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Google Map Api'),
      ),
      body: GoogleMap(
        markers: Set<Marker>.of(myMarkers),
        compassEnabled: true,
        myLocationEnabled: true, // this will show my current location
        mapType: MapType.normal, // this is the type of the map
        // just like the type of the text input type.
        // we can also change it to satalite view. etc.
        onMapCreated: (GoogleMapController controller) {
          myController.complete(controller);
          // so now this mean when the map created the
          // controller also get created so the above step mean that
          // we have assign the default controller of the map
          // to our controller. which is myController.
        },
        initialCameraPosition: KGooglePlex,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.change_circle),
        onPressed: () async {
          setState(() {
            // so basically this will move the map to that
            // place where we put value
            // GoogleMapController controllerr = await controllerr.future;
            newController!.animateCamera(
              CameraUpdate.newCameraPosition(
                const CameraPosition(
                    target: LatLng(25.240460, 51.490860), zoom: 14),
              ),
            );
          });
        },
      ),
    );
  }
}
