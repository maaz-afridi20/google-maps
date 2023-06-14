import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:location_geocoder/location_geocoder.dart';

class AnotherDependencyGeolocator extends StatefulWidget {
  const AnotherDependencyGeolocator({super.key});

  @override
  State<AnotherDependencyGeolocator> createState() =>
      _AnotherDependencyGeolocatorState();
}

class _AnotherDependencyGeolocatorState
    extends State<AnotherDependencyGeolocator> {
  //
  //
  //
  //
  //
// this will change the latlant to its address.

  Future<void> getAddress() async {
    late LocatitonGeocoder geocoder =
        LocatitonGeocoder("AIzaSyDb9YzIlojsmy4csJr9BKXXgaPg_SY4EVc");
    Coordinates coordinates = Coordinates(33.7295, 73.0372);
    try {
      final addresss = await geocoder.findAddressesFromCoordinates(coordinates);
      var message = addresss.first
          .addressLine; // we can get many things like country code etc etc.
      if (message == null) return;
      log(message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
      rethrow;
    }
  }

  // this will change the latlang to its address

  Future<void> getLatLang() async {
    late LocatitonGeocoder geocoder =
        LocatitonGeocoder("AIzaSyDb9YzIlojsmy4csJr9BKXXgaPg_SY4EVc");
    try {
      final address =
          await geocoder.findAddressesFromQuery('islamabad,kpk,Pakistan');
      var message = address.first.coordinates.toString();
      log(message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SOMETING WENT WRONG\nDID YOU ADD API KEY '),
        ),
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              getAddress();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(color: Colors.green),
                child: const Center(
                  child: Text("Convertt"),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              getLatLang();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(color: Colors.green),
                child: const Center(
                  child: Text("Convertt to latlant"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
