import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      //cada vez que se agregue un Place esta pantalla se refresca, creando una lista de Places
      body: FutureBuilder(
        //listen: false, porque queremos q del refresh se encarge el Consumer()
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        //mientras se consulta y espera resultado, se muestra spinner    
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            //una vez finalizada la consulta y actualizado greatPlaces, se ejecuta el Consumer()
            : Consumer<GreatPlaces>(
                //no cambia nunca al actualizar
                child: Center(
                  child: const Text("Aun sin Lugares"),
                ),
                //si no hay Places muestra el Child, sino muestra la lista
                builder: (context, greatPlaces, child) =>
                    greatPlaces.items.length <= 0
                        ? child
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[index].image),
                              ),
                              title: Text(greatPlaces.items[index].title),
                              onTap: () {
                                //ir a pantalla de detalles
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
