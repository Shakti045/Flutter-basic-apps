import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nativefeaturesofmobile/model/place.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:nativefeaturesofmobile/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.setlocation});

  final void Function(PlaceLocation location) setlocation;

  @override
  State<LocationInput> createState() {
    return _LocationInput();
  }
}

class _LocationInput extends State<LocationInput> {
  PlaceLocation? placelocation;
  bool fetchinglocation = false;

  String get imageurl {
    return "https://maps.googleapis.com/maps/api/staticmap?center=${placelocation!.latitude},${placelocation!.longitude}&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C${placelocation!.latitude},${placelocation!.longitude}&key=AIzaSyCDjBEKMawAHiEfaaRTW8vZmDmTPxIfXfw";
  }

  void uselocationdetails(lat, long) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyCDjBEKMawAHiEfaaRTW8vZmDmTPxIfXfw');
    final responce = await http.get(url);
    setState(() {
      fetchinglocation = false;
    });

    if (responce.statusCode >= 400) {
      return;
    }

    String locationstring =
        json.decode(responce.body)['results'][0]['formatted_address'];
    setState(() {
      placelocation = PlaceLocation(
          latitude: lat, longitude: long, locationstring: locationstring);
      widget.setlocation(placelocation!);
    });
  }

  void _getlocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      fetchinglocation = true;
    });
    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final long = locationData.longitude;
    if (lat == null || long == null) {
      setState(() {
        fetchinglocation = false;
      });
      return;
    }
    uselocationdetails(lat, long);
  }

  void _picklocationmanualy() async {
    LatLng? points = await Navigator.of(context).push<LatLng>(MaterialPageRoute(
        builder: (BuildContext context) => const MapScreen(isviewmode: false)));

    if (points == null) {
      return;
    }

    setState(() {
      fetchinglocation = true;
    });
    uselocationdetails(points.latitude, points.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Text('Pick an location');

    if (fetchinglocation) {
      content = const CircularProgressIndicator();
    }
    if (placelocation != null) {
      content = Image.network(
        imageurl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }
    return Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: const Color.fromARGB(119, 255, 255, 255)),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: content,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        if (placelocation != null) Text(placelocation!.locationstring),
        const SizedBox(
          height: 15,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TextButton(
                  onPressed: _getlocation,
                  child: const Text('Pick current location',)),
              const SizedBox(
                width: 15,
              ),
              TextButton(
                  onPressed: _picklocationmanualy,
                  child: const Text('Pick location from map')),
            ],
          ),
        ),
      ],
    );
  }
}
