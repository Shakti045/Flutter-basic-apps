import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nativefeaturesofmobile/model/place.dart';
import 'package:nativefeaturesofmobile/provider/place.dart';
import 'package:nativefeaturesofmobile/screens/addplace.dart';
import 'package:nativefeaturesofmobile/screens/place_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Place> places = [];
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(placeProvider.notifier).loadprviousplaces();
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    places = ref.watch(placeProvider);
    Widget content = const Center(
      child: Text('No places added till now'),
    );
    if (isloading) {
       content =const Center(
         child:CircularProgressIndicator()
      );
    }
    if (places.isNotEmpty) {
      content = ListView.builder(
          itemCount: places.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PlaceScreen(place: places[index])));
                },
                leading: CircleAvatar(
                  backgroundImage: FileImage(places[index].image),
                  radius: 26,
                ),
                title: Text(places[index].placename),
              ),
            );
          });
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourite places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const AddPlace()));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: content);
  }
}
