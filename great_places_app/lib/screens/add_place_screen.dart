import 'package:flutter/material.dart';

import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add-place";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  //se gestionaran los textfields manualmente
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agrega un Nuevo Lugar"),
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
                    ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text("Agregar Lugar"),
            onPressed: () {},
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
