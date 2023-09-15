import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String locationstring;

  const PlaceLocation(
      {required this.latitude,
      required this.longitude,
      required this.locationstring});
}

class Place {
  final String placename;
  final File image;
  final String id;
  final PlaceLocation location;
  Place({required this.image, required this.placename,required this.location}) : id = uuid.v4();
}
