import 'package:flutter/widgets.dart';

class video_file_model
{

  int id;
  String file_name;
  String file_address;
  String file_address_server;
  String file_type;
  String file_extention;
  String file_size;
  String file_hash;
  String file_date_time;
  int user_id;
  String created_at;
  String updated_at;

  video_file_model({
     this.id,
     this.file_name,
     this.file_address,
     this.file_address_server,
     this.file_type,
     this.file_extention,
     this.file_size,
     this.file_hash,
     this.file_date_time,
     this.user_id,
     this.created_at,
     this.updated_at,
  });


  factory video_file_model.fromjson(Map<String,dynamic> json)
  {
    debugPrint(json.toString());
    return video_file_model(
        id: json["id"],
        file_name: json["file_name"],
        file_address: json["file_address"],
        file_address_server: json["file_address_server"],
        file_type: json["file_type"],
        file_extention: json["file_extention"],
        file_size: json["file_size"],
        file_hash: json["file_hash"],
        file_date_time: json["file_date_time"],
        user_id: json["user_id"],
        created_at: json["created_at"],
        updated_at: json["updated_at"]
    );
  }


}