import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class PatientMedicalImage extends StatefulWidget {
  @override
  _PatientMedicalImageState createState() => _PatientMedicalImageState();
}

class _PatientMedicalImageState extends State<PatientMedicalImage> {
  File galleryFile;
  @override
  Widget build(BuildContext context) {
    //display image selected from gallery
    imageSelectorGallery() async {
      var galleryFile1 = await ImagePicker().getImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );
      setState(() {
        galleryFile = File(galleryFile1.path);
      });
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Select Image'),
        backgroundColor: Colors.lightGreen,
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return Center(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                new RaisedButton(
                  child: new Text('Select Image from Gallery'),
                  onPressed: imageSelectorGallery,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightGreen)),
                  height: 200.0,
                  width: 300.0,
                  child: galleryFile == null
                      ? Center(child: new Text('Please select an image.'))
                      : Center(child: new Image.file(galleryFile)),
                ),
                Container(
                    margin: EdgeInsets.only(top: 250, left: 0),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      splashColor: Colors.greenAccent,
                      child: new Text('Proceed'),
                      onPressed: () {
                        showSnackBar(context, galleryFile);
                      },
                    )),
              ]));
        },
      ),
    );
  }
}

void showSnackBar(BuildContext context, File galleryFile) {
  var snackbar = SnackBar(
      content: galleryFile == null
          ? Center(child: new Text('Please select an image to proceed.'))
          : Center(child: new Text('Image saved succesfully!')));
  Scaffold.of(context).showSnackBar(snackbar);
}
