import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SearchPlaces extends StatefulWidget {
  const SearchPlaces({super.key});

  @override
  State<SearchPlaces> createState() => _SearchPlacesState();
}

//  the uuid package is use for finding the id of some devicce.

class _SearchPlacesState extends State<SearchPlaces> {
  TextEditingController textEditingController = TextEditingController();

  var uuid = Uuid();
  String token = '123456';

  @override
  void initState() {
    textEditingController.addListener(() {
      onChange();
    });
    super.initState();
  }

  void onChange() {
    if (token == null) {
      setState(() {
        token = uuid.v4();
      });
    } else {}
  }

  void getSuggestion(String input) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seach place here.'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: textEditingController,
            decoration:
                const InputDecoration(hintText: 'Search place with name'),
          ),
        ],
      ),
    );
  }
}
