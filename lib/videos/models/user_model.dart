class user_model
{

  int id;
  String roll;
  String status;
  String access_make_video;
  String access_make_template;
  String mobile;
  String first_name;
  String name;
  String last_name;
  String image;
  String image_th;
  String email;
  String email_verified_at;
  String rule;
  String created_at;
  String updated_at;

  user_model({
     this.id,
     this.roll,
     this.status,
     this.access_make_video,
     this.access_make_template,
     this.mobile,
     this.first_name,
     this.name,
     this.last_name,
     this.image,
     this.image_th,
     this.email,
     this.email_verified_at,
     this.rule,
     this.created_at,
     this.updated_at,
  });


  factory  user_model.fromjson(Map<String,dynamic> json){
    return user_model(
      id: json["id"], 
      roll: json["roll"], 
      status: json["status"], 
      access_make_video: json["access_make_video"], 
      access_make_template: json["access_make_template"], 
      mobile: json["mobile"], 
      first_name: json["first_name"], 
      name: json["name"], 
      last_name: json["last_name"], 
      image: json["image"], 
      image_th: json["image_th"], 
      email: json["email"], 
      email_verified_at: json["email_verified_at"], 
      rule: json["rule"], 
      created_at: json["created_at"], 
      updated_at: json["updated_at"]
    );

  }


}