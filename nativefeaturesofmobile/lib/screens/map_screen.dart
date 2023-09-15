import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nativefeaturesofmobile/model/place.dart';

const PlaceLocation defaultlocation = PlaceLocation(
    latitude: 37.43296265331129,
    longitude: -122.08832357078792,
    locationstring: "");

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key, this.location = defaultlocation, required this.isviewmode});

  final PlaceLocation location;
  final bool isviewmode;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  late LatLng points;
  @override
  void initState() {
    points = LatLng(widget.location.latitude, widget.location.longitude);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: widget.isviewmode?null: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop(points);
              },
              icon: const Icon(Icons.save)),
        ],
        title: Text(
            widget.isviewmode ? 'Your location' : 'Pick a location from map'),
      ),
      body: GoogleMap(
        onTap: widget.isviewmode
            ? null
            : (LatLng loaction) {
                setState(() {
                  points = loaction;
                });
              },
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.location.latitude, widget.location.longitude),
            zoom: 6),
        markers: {
          Marker(
              markerId: const MarkerId('1234'),
              position: LatLng(points.latitude, points.longitude)),
        },
      ),
    );
  }
}
