import 'package:flutter/cupertino.dart';
import 'package:mafatih/videos/models/file_model.dart';
import 'package:mafatih/videos/models/make_pool_model.dart';
import 'package:mafatih/videos/models/video_file_model.dart';

class video_project_model
{

  int? id;
  String? title;
  String? slug;
  int? seen;
  String? music;
  String? description;
  String? status;
  int? delete_flag;
  String? from;
  String? footage_path;
  String? hash_md5;
  String? duration;
  String? user_permission;
  String? admin_permission;
  //int category_id;
  int? user_id;
  int? video_address_file_id;
  int? video_cover_address_file_id;
  String? created_at;
  String? updated_at;
  video_file_model? file;
  video_file_model? cover;
  make_pool_model? make_pool;



  video_project_model({
     this.id,
     this.title,
     this.slug,
     this.seen,
     this.music,
     this.description,
     this.status,
     this.delete_flag,
     this.from,
     this.footage_path,
     this.hash_md5,
     this.duration,
     this.user_permission,
     this.admin_permission,
    // this.category_id,
     this.user_id,
     this.video_address_file_id,
     this.video_cover_address_file_id,
     this.created_at,
     this.updated_at,
     this.file,
     this.cover,
     this.make_pool
  });


  factory video_project_model.fromjson(Map<String,dynamic> json)
  {
    return video_project_model(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        seen: json["seen"],
        music: json["music"],
        description: json["description"],
        status: json["status"],
        delete_flag: json["delete_flag"],
        from: json["from"],
        footage_path: json["footage_path"],
        hash_md5: json["hash_md5"],
        duration: json["duration"],
        user_permission: json["user_permission"],
        admin_permission: json["admin_permission"],
        //category_id: json["category_id"],
        user_id: json["user_id"],
        video_address_file_id: json["video_address_file_id"],
        video_cover_address_file_id: json["video_cover_address_file_id"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
        file: video_file_model.fromjson(json["file"]),
        cover: video_file_model.fromjson(json["cover"]),
        make_pool: make_pool_model.fromjson(json["make_pool"]),
    );
  }


}