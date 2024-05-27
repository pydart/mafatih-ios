// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:crop/crop.dart';
// import 'package:mafatih/videos/Widgets/CropImage.dart';
// import 'package:mafatih/videos/Widgets/SoundPlayer.dart';
//
//
// class layout_sounds extends StatefulWidget
// {
//
//   @override
//   State<StatefulWidget> createState() => layout_sounds_state();
//
// }
//
// class layout_sounds_state extends State<layout_sounds>
// {
//
//   //main function Start
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Container(
//       padding: EdgeInsets.all(14),
//       margin: EdgeInsets.only(top: 14,bottom: 0),
//       width: MediaQuery.of(context).size.width,
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text("انتخاب موزیک",style: TextStyle( fontSize: 14,fontWeight: FontWeight.bold ),)
//           ,
//           Container(
//             margin: EdgeInsets.only(top: 14,bottom: 14),
//             height: 1,
//             color: Color(0XFFd1d6dc),
//           )
//           ,
//           SoundPlayer(address: "https://www.videoir.com/uploads/file/2022/10/10/Y99y2A6JQbUyj0PzEOJTYW12swGlrTrKP1QHjsZ2.mp3")
//           ,
//           ClipRRect(
//             borderRadius: BorderRadius.circular(0),
//             child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: 50,
//             padding: EdgeInsets.all(5),
//             child: TextButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   side: BorderSide(width: 1,color: Color(0XFFd2d7db),style: BorderStyle.solid),
//                   borderRadius: BorderRadius.circular(0)
//                 )
//               ),
//               onPressed: (){
//               },
//               child: Text("آپلود موزیک",style: TextStyle( color: Color(0XFFd2d7db),fontSize: 14 ),),
//             ),
//           ),
//           )
//           ,
//           ClipRRect(
//             borderRadius: BorderRadius.circular(0),
//             child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: 50,
//             padding: EdgeInsets.all(5),
//             child: TextButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   side: BorderSide(width: 1,color: Color(0XFFd2d7db),style: BorderStyle.solid),
//                   borderRadius: BorderRadius.circular(0)
//                 )
//               ),
//               onPressed: (){
//               },
//               child: Text("موزیک های ویدیو آی آر",style: TextStyle( color: Color(0XFFd2d7db),fontSize: 14 ),),
//             ),
//           ),
//           )
//           ,
//           ClipRRect(
//             borderRadius: BorderRadius.circular(0),
//             child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: 50,
//             padding: EdgeInsets.all(5),
//             child: TextButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   side: BorderSide(width: 1,color: Color(0XFFd2d7db),style: BorderStyle.solid),
//                   borderRadius: BorderRadius.circular(0)
//                 )
//               ),
//               onPressed: (){
//               },
//               child: Text("موزیک های من",style: TextStyle( color: Color(0XFFd2d7db),fontSize: 14 ),),
//             ),
//           ),
//           )
//
//
//         ],
//       ),
//     )
//     );
//   }
//   //main function end
//
//
//
//
//
//
// }
//