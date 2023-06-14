import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomWindowInfo extends StatefulWidget {
  const CustomWindowInfo({super.key});

  @override
  State<CustomWindowInfo> createState() => _CustomWindowInfoState();
}

class _CustomWindowInfoState extends State<CustomWindowInfo> {
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

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

  loadData() async {
    for (int i = 0; i < latlang.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: latlang[i],
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              // iss mein hum... siraf text ki jagah.. koii orr b cheez use kr sktay hain
              // jaisay k any widget.
              // Text('abc'),
              // so basically jo ye addinfowindow ye jo hai iss mein 2 cheezain ayengii
              // aik tu ye hai k show kia krwana hai orr aik ye hai
              // k kiss lat lang prr show krna hai..
              Container(
                height: 500,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.yellow,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://media.istockphoto.com/id/1146517111/photo/taj-mahal-mausoleum-in-agra.jpg?s=612x612&w=0&k=20&c=vcIjhwUrNyjoKbGbAQ5sOcEzDUgOfCsm9ySmJ8gNeRk='),
                          fit: BoxFit.fitWidth,
                          filterQuality: FilterQuality.high,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.green,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              'Taj Mahal india khan',
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              latlang[i],
            );
          },
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Custom Window Info'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
                target: LatLng(33.6844, 73.0479), zoom: 12),
            markers: Set<Marker>.of(markers),
            onTap: (argument) {
              customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              customInfoWindowController.onCameraMove!();
              // agar hm ye.. use karein tu jo window info mein
              //
            },
            onMapCreated: (GoogleMapController controller) {
              customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: customInfoWindowController,
            height: 100,
            width: 200,
            offset: 35,
          ),
        ],
      ),
    );
  }
}
