
import 'dart:io';

import 'package:crop/crop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CropImage extends StatefulWidget 
{

  String image_path;
  int width;
  int height;

  CropImage({
     this.image_path,
     this.width,
     this.height,
  });

  @override
  CropImageState createState() => CropImageState( image_path: image_path ,width: width,height: height);
  
}

class CropImageState extends State<CropImage> {


  String image_path;
  int width;
  int height;

  CropImageState({
     this.image_path,
     this.width,
     this.height,
  });


  var controller;


  double _rotation = 0;
  BoxShape shape = BoxShape.rectangle;

  void _cropImage() async {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final cropped = await controller.crop(pixelRatio: pixelRatio);

    if (cropped == null) {
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Crop Result'),
            centerTitle: true,
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () async {
                  },
                ),
              ),
            ],
          ),
          body: Center(
            child: RawImage(
              image: cropped,
            ),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller=CropController(aspectRatio: width / height);
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8),
              child: Crop(
                backgroundColor: Colors.white,
                onChanged: (decomposition) {
                  if (_rotation != decomposition.rotation) {
                    setState(() {
                      _rotation = ((decomposition.rotation + 0) % 360) - 180;
                    });
                  }

                  // print(
                  //     "Scale : ${decomposition.scale}, Rotation: ${decomposition.rotation}, translation: ${decomposition.translation}");
                },
                controller: controller,
                shape: shape,
                child: Image.file(
                  File(image_path),
                  fit: BoxFit.cover,
                ),
                /* It's very important to set `fit: BoxFit.cover`.
                   Do NOT remove this line.
                   There are a lot of issues on github repo by people who remove this line and their image is not shown correctly.
                */
                foreground: IgnorePointer(
                  child: Container(
                    alignment: Alignment.bottomRight,
                  ),
                ),
                helper: shape == BoxShape.rectangle
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      )
                    : null,
              ),
            ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

                ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
            width: 150,
            height: 50,
            padding: EdgeInsets.all(5),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                )
              ),
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("انصراف",style: TextStyle( color: Colors.white ),),
            ),
          ),
          )
          ,

              ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
            width: 150,
            height: 50,
            padding: EdgeInsets.all(5),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                )
              ),
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("ذخیره",style: TextStyle( color: Colors.white ),),
            ),
          ),
          )
          ,
          

            ],
          )



        ],
      ),
    );
  }


}




// Row(
//             children: <Widget>[
//               IconButton(
//                 icon: const Icon(Icons.undo),
//                 tooltip: 'Undo',
//                 onPressed: () {
//                   controller.rotation = 0;
//                   controller.scale = 1;
//                   controller.offset = Offset.zero;
//                   setState(() {
//                     _rotation = 0;
//                   });
//                 },
//               ),
//               PopupMenuButton<BoxShape>(
//                 icon: const Icon(Icons.crop_free),
//                 itemBuilder: (context) => [
//                   const PopupMenuItem(
//                     child: Text("Box"),
//                     value: BoxShape.rectangle,
//                   ),
//                   const PopupMenuItem(
//                     child: Text("Oval"),
//                     value: BoxShape.circle,
//                   ),
//                 ],
//                 tooltip: 'Crop Shape',
//                 onSelected: (x) {
//                   setState(() {
//                     shape = x;
//                   });
//                 },
//               ),
//               PopupMenuButton<double>(
//                 icon: const Icon(Icons.aspect_ratio),
//                 itemBuilder: (context) => [
//                   const PopupMenuItem(
//                     child: Text("Original"),
//                     value: 1000 / 667.0,
//                   ),
//                   const PopupMenuDivider(),
//                   const PopupMenuItem(
//                     child: Text("16:9"),
//                     value: 16.0 / 9.0,
//                   ),
//                   const PopupMenuItem(
//                     child: Text("4:3"),
//                     value: 4.0 / 3.0,
//                   ),
//                   const PopupMenuItem(
//                     child: Text("1:1"),
//                     value: 1,
//                   ),
//                   const PopupMenuItem(
//                     child: Text("3:4"),
//                     value: 3.0 / 4.0,
//                   ),
//                   const PopupMenuItem(
//                     child: Text("9:16"),
//                     value: 9.0 / 16.0,
//                   ),
//                 ],
//                 tooltip: 'Aspect Ratio',
//                 onSelected: (x) {
//                   controller.aspectRatio = x;
//                   setState(() {});
//                 },
//               ),
//             ],
//           ),