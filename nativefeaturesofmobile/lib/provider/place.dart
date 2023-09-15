import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nativefeaturesofmobile/model/place.dart';

import 'package:path_provider/path_provider.dart' as systempath;
import 'package:path/path.dart' as path;

import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> getorcreatedatabase() async {
  //  here we get the path of the localdatabase of the system
  final dbpathofsystem = await sql.getDatabasesPath();

  // it creates a database by the given name and returns the database to perform query,if database exists it simply returns that database
  final Database db = await sql.openDatabase(
      path.join(dbpathofsystem, 'places.db'), onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY,placename TEXT,imagepath TEXT,lat REAL,long REAL,locationname TEXT)');
  }, version: 1);
  return db;
}

class PlaceNotifier extends StateNotifier<List<Place>> {
  PlaceNotifier() : super(const []);

  void addplace(Place place) async {
    //to save localy we need the path given to our application by os of system because the path we are using is a temporary path that can be deleted or cleared by os
    final applicatidir = await systempath.getApplicationDocumentsDirectory();

    // using path.basename() we can know the filename of the file
    final filename = path.basename(place.image.path);

    //using image.copy we copied the image from temporay path to our applicationdirectory after coapy it returns the copied file;

    final File copiedimage =
        await place.image.copy(path.join('${applicatidir.path}/$filename'));

    Database db = await getorcreatedatabase();
    await db.insert('user_places', {
      'id': place.id,
      'placename': place.placename,
      'imagepath': copiedimage.path,
      'lat': place.location.latitude,
      'long': place.location.longitude,
      'locationname': place.location.locationstring
    });

    state = [place, ...state];
  }

  Future loadprviousplaces() async {
    Database db = await getorcreatedatabase();
    List data = await db.query('user_places');

    List<Place> previousdata = data.map((e) {
      return Place(
          image: File(e['imagepath'] as String),
          placename: e['placename'] as String,
          location: PlaceLocation(
              latitude: e['lat'] as double,
              longitude: e['long'] as double,
              locationstring: e['locationname'] as String));
    }).toList();

    state = previousdata;
  }
}

final placeProvider =
    StateNotifierProvider<PlaceNotifier, List<Place>>((ref) => PlaceNotifier());
