import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart'; //para poder usar ChangeNotifier y notifyListeners()

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  
  List<Place> _items = [];

  List<Place> get items {
    //se retorna copia de la lista de lugares
    return [..._items];
  }

}