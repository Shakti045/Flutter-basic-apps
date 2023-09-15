import 'package:flutter/material.dart';
import 'package:nativefeaturesofmobile/model/place.dart';
import 'package:nativefeaturesofmobile/screens/map_screen.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({super.key, required this.place});
  final Place place;

  String get imageurl {
    PlaceLocation placeLocation = place.location;
    return "https://maps.googleapis.com/maps/api/staticmap?center=${placeLocation!.latitude},${placeLocation!.longitude}&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C${placeLocation!.latitude},${placeLocation!.longitude}&key=AIzaSyCDjBEKMawAHiEfaaRTW8vZmDmTPxIfXfw";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.placename),
      ),
      body: Stack(children: [
        Image.file(
          place.image,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => MapScreen(
                                isviewmode: true,
                                location: place.location,
                              )));
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(imageurl),
                      radius: 60,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    place.location.locationstring,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ))
      ]),
    );
  }
}
