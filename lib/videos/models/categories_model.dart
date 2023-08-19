import 'package:flutter/cupertino.dart';

class categories_model
{
  int id;
  String name;
  String slug;
  String status;

  categories_model({
     this.id,
     this.name,
     this.slug,
     this.status
  });


  factory categories_model.fromjson(Map<String,dynamic> json)
  {
    // debugPrint("Get Cats "+json.toString());
    return categories_model(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        status: json["status"]
    );
  }

}