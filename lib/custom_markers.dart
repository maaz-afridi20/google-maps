import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerss extends StatefulWidget {
  const CustomMarkerss({super.key});

  @override
  State<CustomMarkerss> createState() => _CustomMarkerssState();
}

class _CustomMarkerssState extends State<CustomMarkerss> {
  CameraPosition initialPos =
      const CameraPosition(target: LatLng(33.7294, 73.0395), zoom: 14);

  final Completer<GoogleMapController> completerController = Completer();

  Uint8List? markerImage;

  Future<Uint8List> getBytesFromAsset(String path, int height) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: height,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  List<String> imageslist = [
    'assets/bb.png',
    'assets/bike.png',
    'assets/bike2.png',
    'assets/bike3.png',
    'assets/car.png',
    'assets/car2.png'
  ];

  final List<Marker> markers = [];
  //
  final List<LatLng> latlang = const <LatLng>[
    LatLng(33.6844, 73.0479),
    LatLng(33.6845, 73.0861),
    LatLng(33.7215, 73.0765),
    LatLng(33.6928, 73.0551),
    LatLng(33.6908, 73.0163),
    LatLng(33.7234, 73.0602),
  ];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    setState(() async {
      for (int i = 0; i < imageslist.length; i++) {
        final Uint8List markerIcon =
            await getBytesFromAsset(imageslist[i], 100);
        markers.add(
          Marker(
            markerId: MarkerId(
              i.toString(),
            ),
            position: latlang[i],
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow: InfoWindow(
              title: 'this is title no ' + i.toString(),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            completerController.complete(controller);
          },
          markers: Set<Marker>.of(markers),
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: initialPos),
    );
  }
}
