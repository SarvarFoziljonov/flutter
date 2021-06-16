import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class MyUploadPage extends StatefulWidget {
  @override
  _MyUploadPageState createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {

  var _captionController = TextEditingController();
  //  Beginning functions of choose photo from gallery // camera
  File _image;

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }


  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(

              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Pick Photo'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Take Photo'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  //  ^^^ Ending functions of choose photo from gallery // camera ^^^

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Upload", style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'Billabong'),),
        actions: [
          IconButton(
            icon: Icon(Icons.post_add, color: Color.fromRGBO(252, 175, 69, 1),),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              //camera icon
              GestureDetector(
                onTap: () {
                _showPicker(context);
                },
                child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width,
                    color: Colors.grey.withOpacity(0.4),
                    child: _image == null
                    ? Center(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 70,
                        color: Colors.grey,
                      ),
                    )
                  : Stack(
                      children: [
                        Image.file(_image, width: double.infinity, height: double.infinity, fit: BoxFit.cover,),
                        Container(
                          width: double.infinity,
                          color: Colors.black12,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: (){
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                icon: Icon(Icons.highlight_remove),
                                color: Colors.white,
                              ),
                            ],
                        ),
                        ),
                      ],
                    )
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: TextField(
                  controller: _captionController,
                 style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Caption",
                    hintStyle: TextStyle(color: Colors.black38, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),

        ),
      )
    );
  }
}
