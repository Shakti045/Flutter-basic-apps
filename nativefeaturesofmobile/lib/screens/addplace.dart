import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nativefeaturesofmobile/model/place.dart';
import 'package:nativefeaturesofmobile/provider/place.dart';
import 'package:nativefeaturesofmobile/widget/imageinput.dart';
import 'package:nativefeaturesofmobile/widget/locationinput.dart';


class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddplaceState();
  }
}

class _AddplaceState extends ConsumerState {
  final _placename = TextEditingController();

  PlaceLocation? placeLocation;
  File? image;

  @override
  void dispose() {
    _placename.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add your favourite place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Place name'),
                controller: _placename,
              ),
              ImageInput(setimage: (File img) {
                image = img;
              }),
              const SizedBox(
                height: 15,
              ),
              LocationInput(setlocation: (PlaceLocation location) {
                  placeLocation = location;
              }),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (image == null ||
                        placeLocation == null || _placename.text.isEmpty)  {
        
                      return;
                    }
                    Place place = Place(
                        image: image!,
                        location: placeLocation!,
                        placename: _placename.text);
                    ref.read(placeProvider.notifier).addplace(place);
                    Navigator.of(context).pop();
                  },
                  child: const Text('CREATE PLACE',textAlign:TextAlign.center)),
            ],
          ),
        ),
      ),
    );
  }
}
