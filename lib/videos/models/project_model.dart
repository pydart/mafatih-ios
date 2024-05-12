class project_model
{

  String? current_page;
  String? first_page_url;
  String? last_page;
  String? last_page_url;
  String? path;


  project_model({
     this.current_page,
     this.first_page_url,
     this.last_page,
     this.last_page_url,
     this.path,
  });


  factory project_model.from_json(Map<String,dynamic> json){

    return project_model(
      current_page: json["current_page"], 
      first_page_url: json["first_page_url"], 
      last_page: json["last_page"], 
      last_page_url: json["last_page_url"], 
      path: json["path"]
      );

  }


}