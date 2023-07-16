import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:mafatih/videos/models/categories_model.dart';
import 'package:mafatih/videos/models/file_model.dart';

class theme_model
{

  int id;
  String title;
  String slug;
  int seen;
  String duration;
  String video_address;
  String cover_address;
  String cover_time;
  String cover_status;
  int category_id;
  int user_id;
  String created_at;
  String updated_at;
  // List<file_model> files;
  // int access_id;
  //
  //
  // String description;
  // String json;
  // String size_9;
  // String size_1;
  // String size_16;
  // String status;
  //categories_model category;

  theme_model({
     this.id,
     this.title,
     this.slug,
     this.seen,
     this.duration,
     this.video_address,
     this.cover_address,
     this.cover_time,
     this.cover_status,
     this.category_id,
     this.user_id,
     this.created_at,
     this.updated_at,

    // this.category
  });


  factory theme_model.fromjson(Map<String,dynamic> json)
  {
    return theme_model(
        id: json["id"], 
        title: json["title"], 
        slug: json["slug"],
      seen: json["seen"],
        duration: json["duration"],
      video_address: json["video_address"],
      cover_address: json["cover_address"],
      cover_time: json["cover_time"],
      cover_status: json["cover_status"],
        category_id: json["category_id"],
      user_id: json["user_id"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
        //category: categories_model.fromjson(jsonDecode(json["category"].toString()))
    );
  }


}