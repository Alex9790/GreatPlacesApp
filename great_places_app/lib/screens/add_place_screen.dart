import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../providers/great_places.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  //se gestionaran los textfields manualmente
  final _titleController = TextEditingController();
  File _pickedImage;

  //callback function para el image_input, toma la imagen de aquel widget y la carga aqui
  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void _savePlace(){
    //validando el input
    if(_titleController.text.isEmpty || _pickedImage == null){
      //se puede mostrar aqui mensaje de error, dialog, etc
      return;
    }

    //agregando Place, no estamos interesado en "listen" en esta pantalla
    Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage);

    //para regresar a la pantalla anterior
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Place"),
      ),
      //se quiere datos de entrada arriba y al fnal el boton de agregar, siempre se quede abajo
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //para que tomen todo el ancho disponible
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //combinando Expanded para los inputs y dejando raisedButton por fuera
          //se consigue que expande tome todo el espacio que pueda y para los demas deja solo el espacio q
          //necesita obligatoriamente
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: "Titulo"),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    //imagen
                    ImageInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          //boton submit
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text("Agregar Lugar"),
            onPressed: _savePlace,
            //para que se vea flat
            elevation: 0,
            //para eliminar un margen minimo que tiene por defecto para que cubra todo el espacio asignado
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
