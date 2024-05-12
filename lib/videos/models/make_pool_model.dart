class make_pool_model
{

  int? id;
  String? status;
  int? importance;
  int? percent;
  String? delete_flag;
  int? file_id;
  int? template_id;
  int? video_id;
  int? user_id;

  make_pool_model({
     this.id,
     this.status,
     this.importance,
     this.percent,
     this.delete_flag,
     this.file_id,
     this.template_id,
     this.video_id,
     this.user_id,
  });


  factory make_pool_model.fromjson(Map<String,dynamic> json)
  {
    return make_pool_model(
        id: json["id"],
        status: json["status"],
        importance: json["importance"],
        percent: json["percent"],
        delete_flag: json["delete_flag"],
        file_id: json["file_id"],
        template_id: json["template_id"],
        video_id: json["video_id"],
        user_id: json["user_id"]
    );
  }


}