import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; //para poder usar ChangeNotifier y notifyListeners()

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    //se retorna copia de la lista de lugares
    return [..._items];
  }

  //registrando Places
  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );

    _items.add(newPlace);
    notifyListeners();
    //insertando en DB
    DBHelper.insert("user_places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData("user_places");

    _items = dataList
        .map(
          (item) => Place(
              id: item["id"],
              title: item["title"],
              location: null,
              image: File(item["image"])),
        )
        .toList();

    notifyListeners();
  }
}
