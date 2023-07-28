// import 'package:flutter/material.dart';
// import 'package:mafatih/videos/Screens/Activity_Review.dart';
// import 'package:mafatih/videos/Screens/Activity_ShowAllStoreies.dart';
// import 'package:mafatih/videos/Screens/Activity_ShowAllVideo.dart';
//
// class layout_theme extends StatelessWidget
// {
//
//   //Main function start
//   @override
//   Widget build(BuildContext context)
//   {
//     return SingleChildScrollView(
//       child: Directionality(
//       textDirection: TextDirection.rtl ,
//       child: Container(
//         child: Column(
//           children: [
//
//             TopVideoBoxes(context),
//             // ,
//             StoriesSection(context),
//             // ,
//             videosSection(context)
//
//           ],
//         ),
//       )
//     ),
//     );
//   }
//   //Main function end
//
//
//   //Get Top Items Start
//   Widget TopVideoBoxes(BuildContext context)
//   {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//
//         Container(
//           width: MediaQuery.of(context).size.width/2-10,
//           color: Colors.white,
//           height: 140,
//           child: Column(
//             children: [
//               Image.network("https://www.videoir.com/FileManager/themes/00c3617e06d3243d792cfd381f39b19e7b8c02e74329dcf91aa73f9dc4ea8c19/338-cover.jpg",height: 100,fit: BoxFit.cover,)
//               ,
//               Container(
//                 padding: EdgeInsets.all(5),
//                 height: 40,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//
//                   Container(
//                     width: 35,
//                     height: 25,
//                     margin: EdgeInsets.only(left: 8,right: 8),
//                     child: Icon(Icons.play_arrow,color: Colors.green),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       border: Border.all(width: 1,color: Colors.green,style: BorderStyle.solid)
//                     ),
//                   )
//                   ,
//                   Text("قالب دیجیتال مارکتینگ",style: TextStyle( color: Colors.black87 ,fontSize: 10,fontWeight: FontWeight.bold),)
//
//                 ],
//               ),
//               )
//             ],
//           ),
//         )
//         ,
//         Container(
//           width: MediaQuery.of(context).size.width/2-10,
//           color: Colors.white,
//           height: 140,
//           child: Column(
//             children: [
//               Image.network("https://www.videoir.com/FileManager/themes/00c3617e06d3243d792cfd381f39b19e7b8c02e74329dcf91aa73f9dc4ea8c19/338-cover.jpg",height: 100,fit: BoxFit.cover,)
//               ,
//               Container(
//                 padding: EdgeInsets.all(5),
//                 height: 40,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//
//                   Container(
//                     width: 35,
//                     height: 25,
//                     margin: EdgeInsets.only(left: 8,right: 8),
//                     child: Icon(Icons.play_arrow,color: Colors.green),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       border: Border.all(width: 1,color: Colors.green,style: BorderStyle.solid)
//                     ),
//                   )
//                   ,
//                   Text("قالب دیجیتال مارکتینگ",style: TextStyle( color: Colors.black87 ,fontSize: 10,fontWeight: FontWeight.bold),)
//
//                 ],
//               ),
//               )
//             ],
//           ),
//         )
//
//       ],
//     )
//     );
//   }
//   //Get Top Items End
//
//
//   //Stories section Start
//   Widget StoriesSection(BuildContext context)
//   {
//     return Container(
//       margin: EdgeInsets.only(top: 6),
//       child: Column(
//       children: [
//
//         Container(
//           margin: EdgeInsets.all(14),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//
//             Text("قالب های استوری",style: TextStyle( fontSize: 13 ))
//             ,
//             TextButton(
//               style: TextButton.styleFrom(
//                 shape:RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   side: BorderSide(width: 1,color: Colors.red)
//                 )
//               ),
//               onPressed: (){
//                   Navigator.push(context, (MaterialPageRoute(builder: (context)=>Activity_ShowAllStoreies() )));
//               },
//               child: Text("نمایش همه",style: TextStyle( fontSize: 13 ))
//             )
//
//           ],
//         ),
//         )
//         ,
//         Container(
//           height: 200,
//           child: ListView.builder(
//           itemCount: 10,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index)
//           {
//             return Padding(
//               padding: EdgeInsets.all(6),
//               child: TextButton(
//               style: TextButton.styleFrom(
//                 padding: EdgeInsets.all(0)
//               ),
//               onPressed: (){
//                 //Navigator.push(context, MaterialPageRoute(builder: (context)=> Activity_Review()));
//               },
//               child: Container(
//                 width: 115,
//                 height: 200,
//                 child: Image.network("https://www.videoir.com/FileManager/themes/00c3617e06d3243d792cfd381f39b19e7b8c02e74329dcf91aa73f9dc4ea8c19/144-cover.jpg",height: 270,fit: BoxFit.cover),
//               )
//             ),
//             );
//           }
//           )
//         )
//
//       ],
//     ),
//     );
//   }
//   //Stories section End
//
//
//   //Video section Start
//   Widget videosSection(BuildContext context)
//   {
//     return Container(
//       margin: EdgeInsets.only(top: 6),
//       child: Column(
//       children: [
//
//         Container(
//           margin: EdgeInsets.all(14),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//
//             Text("قالب های ویدیو",style: TextStyle( fontSize: 13 ))
//             ,
//             TextButton(
//               style: TextButton.styleFrom(
//                 shape:RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   side: BorderSide(width: 1,color: Colors.green)
//                 )
//               ),
//               onPressed: (){
//
//                 Navigator.push(context, (MaterialPageRoute(builder: (context)=>Activity_ShowAllVideo(catgegory.id.toString()) )));
//
//               },
//               child: Text("نمایش همه",style: TextStyle( fontSize: 13 ))
//             )
//
//           ],
//         ),
//         )
//         ,
//         Container(
//           height: 120,
//           child: ListView.builder(
//           itemCount: 10,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index)
//           {
//             return Padding(
//               padding: EdgeInsets.all(6),
//               child: TextButton(
//               style: TextButton.styleFrom(
//                 padding: EdgeInsets.all(0)
//               ),
//               onPressed: (){
//                 //Navigator.push(context, MaterialPageRoute(builder: (context)=> Activity_Review()));
//               },
//               child: Container(
//                 width: 200,
//                 height: 120,
//                 child: Image.network("https://www.videoir.com/FileManager/themes/00c3617e06d3243d792cfd381f39b19e7b8c02e74329dcf91aa73f9dc4ea8c19/338-cover.jpg",height: 120,fit: BoxFit.cover),
//               )
//             ),
//             );
//           }
//           )
//         )
//
//       ],
//     ),
//     );
//   }
//   //Video section End
//
//
//
//
// }