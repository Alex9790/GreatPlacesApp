import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {

  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  //para activar tomar foto con la camara del dispositivo
  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    //en caso de que el archivo sea null, el usuario no tomo foto
    if(imageFile == null){
      return;
    }

    setState(() {
      _storedImage = imageFile;
    });
    //direccion de la app en dispositivo
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    //nombre del archivo de la imagen a partir de toda su ruta
    final fileName = path.basename(imageFile.path);
    //guardando imagen dentro de la direccon de la app
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');

    //se usa esta propiedad que nos da acceso a la clase ImageInput para acceder a la CallBack Function
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  "Aun sin Imagen",
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(height: 10),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text("Toma un Foto"),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
