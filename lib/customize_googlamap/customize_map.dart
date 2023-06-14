import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomizeGoogleMap extends StatefulWidget {
  const CustomizeGoogleMap({super.key});

  @override
  State<CustomizeGoogleMap> createState() => _CustomizeGoogleMapState();
}

class _CustomizeGoogleMapState extends State<CustomizeGoogleMap> {
  String mapTheme = '';

  CameraPosition initialpos =
      const CameraPosition(target: LatLng(33.6941, 72.9734), zoom: 13);
  Completer<GoogleMapController> completerGoogleMap = Completer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/map_theme/silver_theme.json')
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize maps'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text('Silver'),
                  onTap: () {
                    completerGoogleMap.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/map_theme/silver_theme.json')
                          .then((valuee) {
                        value.setMapStyle(valuee);
                      });
                    });
                  },
                ),
                PopupMenuItem(
                  child: const Text('night'),
                  onTap: () {
                    completerGoogleMap.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/map_theme/night_theme.json')
                          .then((valuee) {
                        value.setMapStyle(valuee);
                      });
                    });
                  },
                ),
                PopupMenuItem(
                  child: const Text('dark'),
                  onTap: () {
                    completerGoogleMap.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/map_theme/dark_theme.json')
                          .then((valuee) {
                        value.setMapStyle(valuee);
                      });
                    });
                  },
                ),
                PopupMenuItem(
                  child: const Text('retro'),
                  onTap: () {
                    completerGoogleMap.future.then((value) {
                      DefaultAssetBundle.of(context)
                          .loadString('assets/map_theme/retro_theme.json')
                          .then((valuee) {
                        value.setMapStyle(valuee);
                      });
                    });
                  },
                ),
              ];
            },
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: initialpos,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (controller) {
          completerGoogleMap.complete(controller);
          controller.setMapStyle(mapTheme);
        },
      ),
    );
  }
}
