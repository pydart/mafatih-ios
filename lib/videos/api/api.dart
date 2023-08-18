import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mafatih/videos/Server/server.dart';
import 'package:mafatih/videos/data/DataSaver/DataSaver.dart';
import 'package:mafatih/videos/data/data.dart';
import 'package:mafatih/videos/models/categories_model.dart';
import 'package:mafatih/videos/models/project_model.dart';
import 'package:mafatih/videos/models/theme_model.dart';
import 'package:mafatih/videos/models/user_model.dart';
import 'package:mafatih/videos/models/video_project_model.dart';


class api
{


  //Login Start
  Future<bool> Login(String username,String password) async
  {
    print('///////////////////////////////////////////////////////// login');

    String response=await server().Post("auth/login",{"email_mobile":username,"password":password}, false);
    print('///////////////////////////////////////////////////////// $response');

    JsonDecoder decoder=new JsonDecoder();
    Map<String,dynamic> json=decoder.convert(response);

    if(!response.toString().contains("message"))
    {
      token=json["data"]["token"];
      user=user_model(
        id: json["data"]["user"]["id"], 
        roll: json["data"]["user"]["roll"].toString(), 
        status: json["data"]["user"]["status"].toString(), 
        access_make_video: json["data"]["user"]["access_make_video"].toString(), 
        access_make_template: json["data"]["user"]["access_make_template"].toString(), 
        mobile: json["data"]["user"]["mobile"].toString(), 
        first_name: json["data"]["user"]["first_name"].toString(), 
        name: json["data"]["user"]["name"].toString(), 
        last_name: json["data"]["user"]["last_name"].toString(), 
        image: json["data"]["user"]["image"].toString(), 
        image_th: json["data"]["user"]["image_th"].toString(), 
        email: json["data"]["user"]["email"].toString(), 
        email_verified_at: json["data"]["user"]["email_verified_at"].toString(), 
        rule: json["data"]["user"]["rule"].toString(), 
        created_at: json["data"]["user"]["created_at"].toString(), 
        updated_at: json["data"]["user"]["updated_at"].toString()
      );
      
      Data_Sever.Save_Data("token", token);

      return true;
    }
    else
    {
      Fluttertoast.showToast(
          msg: json["message"],
          backgroundColor: Colors.red,
          gravity: ToastGravity.CENTER,
          webPosition: "center",
          webBgColor: "#FF0000",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          fontSize: 16.0
      );

      print('///////////////////////////////////////////////////////// $json["message"]');


    }

    return false;
  }
  //Login End


  //Logout Start
  Future<void> Logout()async
  {
    String resposne=await server().Get("auth/logout", true);
  }
  //Logout End


  //Get user data with token Start
  Future<bool> GetUserData(String token) async
  {
    String response=await server().Get("app/all-info", true);
    //debugPrint(response);
    JsonDecoder decoder=new JsonDecoder();
    Map<String,dynamic> json=decoder.convert(response);
    
    if(!response.toString().contains("message"))
    {
      user=user_model(
        id: json["data"]["user"]["id"], 
        roll: json["data"]["user"]["roll"].toString(), 
        status: json["data"]["user"]["status"].toString(), 
        access_make_video: json["data"]["user"]["access_make_video"].toString(), 
        access_make_template: json["data"]["user"]["access_make_template"].toString(), 
        mobile: json["data"]["user"]["mobile"].toString(), 
        first_name: json["data"]["user"]["first_name"].toString(), 
        name: json["data"]["user"]["name"].toString(), 
        last_name: json["data"]["user"]["last_name"].toString(), 
        image: json["data"]["user"]["image"].toString(), 
        image_th: json["data"]["user"]["image_th"].toString(), 
        email: json["data"]["user"]["email"].toString(), 
        email_verified_at: json["data"]["user"]["email_verified_at"].toString(), 
        rule: json["data"]["user"]["rule"].toString(), 
        created_at: json["data"]["user"]["created_at"].toString(), 
        updated_at: json["data"]["user"]["updated_at"].toString()
      );
      
      return true;
    }
    else
    {
      Fluttertoast.showToast(
          msg: json["message"],
          backgroundColor: Colors.red,
          gravity: ToastGravity.CENTER,
          webPosition: "center",
          webBgColor: "#FF0000",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          fontSize: 16.0
      );
      
    }

    return false;
  }
  //Get user data with token Start


  //Send register sms to user start
  Future<String> SendRegisterSms(String mobile)async
  {
    String resposne=await server().Post("auth/send-sms", { "mobile":mobile },false);
    return resposne;
  }
  //Send register sms to user end


  //Send forget password sms start
  Future<String> SendForgetPasswordSMS(String mobile ) async
  {
    String resposne=await server().Post("auth/send-sms-forget-pass", { "mobile":mobile },false);
    return resposne;
  }
  //Send forget password sms end


  //Check forget password code start
  Future<bool> CheckForgetPasswordCode(String mobile,String code) async
  {
    
    String resposne=await server().Post("auth/forget-pass", { "mobile":mobile,"code":code },false);

    if(resposne.contains("message"))
    {
      Fluttertoast.showToast(
          msg: jsonDecode(resposne)["message"],
          backgroundColor: Colors.red,
          gravity: ToastGravity.CENTER,
          webPosition: "center",
          webBgColor: "#FF0000",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return false;
    }
    else
    {
      return true;
    }
  }
  //Check forget password code end


  //Set new password forgetpassword start
  Future<String> OverwiteNewPasswordForgetPassword(String mobile,String code,String password,String re_password)async
  {
    String resposne=await server().Post("auth/forget-pass", { "mobile":mobile ,"code":code,"password":password,"password_confirmation":re_password},false);
    return resposne;
  }
  //Set new password forgetpassword end


  //Register new user start
  Future<String> RegisterNewUser(String mobile,String code,String email,String username,String password,String re_password)async
  {
    String resposne=await server().Post("auth/register", { "mobile":mobile ,"code":code,"email":email,"name":username,"password":password,"password_confirmation":re_password},false);
    return resposne;
  }
  //Register new user end


  //Get all themplate start
  Future<List<theme_model>> GetAllThemeData() async
  {
    String resposne=await server().Get("app/index",true);
    List all = jsonDecode(resposne)["data"]["story"];
    story=List<theme_model>.from(all.map((x) => theme_model.fromjson(x)));
    return story;
  }
  //Get all themplate end


  //Set new settings start
  Future<void> SetNewNameFamilyAndPassword(String first_name,String last_name,String password) async
  {
    String resposne;

    if(password=="")
    {
      resposne=await server().Post("panel/setting",{"first_name":first_name,"last_name":last_name},true);
    }
    else
    {
      resposne=await server().Post("panel/setting",{"first_name":first_name,"last_name":last_name,"password":password},true);
    }

    user.first_name=first_name;
    user.last_name=last_name;
    //debugPrint("Setting response is : "+resposne);

    Fluttertoast.showToast(
        msg: "تغییرات با موفقیت اعمال شد",
        backgroundColor: Colors.green,
        gravity: ToastGravity.CENTER,
        webPosition: "center",
        webBgColor: "#7ecb20",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }
  //Set new settings end



  //Get all categories start
  Future<List<categories_model>> GetAllCategories() async
  {

    var response = await server().Get("app/categories",true);

    List all_cat=jsonDecode(response)["data"]["categories"];
    all_categories=List<categories_model>.from(all_cat.map((x) => categories_model.fromjson(x)));
    return all_categories;
  }
  //Get all categories end



  //Get all categories start
  Future<List<theme_model>> GetAllThemeOfCategories() async
  {
    // var response = await server().Post("app/cat-templates",{ "category_id" : selected_category_index.toString() },true);
    var response = await server().Get("app/categories-videos",true);
    print("//////////////////////////////////               //////////////  $response");

    List all_cat=jsonDecode(response)["data"]["categories"][0]["index_video"];
    print("//////////////////////////////////               //////////////  $all_cat");

    List<theme_model> result=List<theme_model>.from(all_cat.map((x) => theme_model.fromjson(x)));
    // print("//////////////////////////////////               //////////////  $result");

    return result;
  }
  //Get all categories end

  // //Get all categories start
  // String GetAllVideosPerPage(page)
  // {
  //   // var response = await server().Post("app/cat-templates",{ "category_id" : selected_category_index.toString() },true);
  //   var response =  server().Get("video/all?page=$page",true);
  //   print("//////////////////////////////////               //////////////  $response");
  //
  //   List all_vid_each_page=jsonDecode(response)["data"];
  //   print("//////////////////////////////////               //////////////  $all_vid_each_page");
  //
  //   // List<theme_model> result=List<theme_model>.from(all_vid_each_page.map((x) => theme_model.fromjson(x)));
  //   // print("//////////////////////////////////               //////////////  $result");
  //
  //   return all_vid_each_page;
  // }
  // //Get all categories end



  //Get all categories start
  Future<List<theme_model>> GetAllThemeOfCategoriesById(String cat_id) async
  {
    var response = await server().Post("video/all",{ "category_id" : cat_id },true);

    List all_cat=jsonDecode(response)["data"]["videos"]["data"];
    // print("//////////////////////////////////               //////////////  $all_cat");

    List<theme_model> result=List<theme_model>.from(all_cat.map((x) => theme_model.fromjson(x)));
    return result;
  }
  //Get all categories end

  //Get all videos by page start
  Future<List<theme_model>> GetAllVideosPerPage(String cat_id, String page) async
  {
    print("//////////////////////////////////               GetAllVideosPerPage////////////// start");
    var response = await server().Get("app/category/$cat_id",true);
    // var response = await server().Post("video/all",{ "category_id" : cat_id , "page" : page},true);
    // List all_vid_each_page=jsonDecode(response)["data"]["videos"]["data"];
    // print("//////////////////////////////////               GetAllVideosPerPage////////////// ${(jsonDecode(response)["data"]["videos"])}");
    List all_vid_each_page=jsonDecode(response)["data"]["videos"];
    // List all_vid_each_page=[];
    // for (var i = 1; i <= ((jsonDecode(response)["data"]["videos"]["total"] / jsonDecode(response)["data"]["videos"]["per_page"]).floor())+1; i++){
    //   var response = await server().Post("video/all",{ "category_id" : cat_id , "page" : i.toString()},true);
    //   List all_vid_each_page_1=jsonDecode(response)["data"]["videos"]["data"];
    //   all_vid_each_page.addAll(all_vid_each_page_1);
    // }

    List<theme_model> result=List<theme_model>.from(all_vid_each_page.map((x) => theme_model.fromjson(x)));
    return result;
  }
  //Get all categories end



  //Get All Themes start
  Future<List<theme_model>> GetAllThemes() async
  {
    var response = await server().Get("app/all-template",true);
    List all_cat=jsonDecode(response)["data"]["templates"]["data"];
    List<theme_model> result=List<theme_model>.from(all_cat.map((x) => theme_model.fromjson(x)));
    return result;
  }
  //Get All Themes end




  //Get all list start
  Future<List<video_project_model>> GetCurentProjects() async
  {
    video_projects_list.clear();
    var response = await server().Get("panel/all-list",true);
    List all_video=jsonDecode(response)["data"]["videos"]["data"];
    return List<video_project_model>.from(all_video.map((x) => video_project_model.fromjson(x)));
  }
  //Get all list end


  //Get all list start
  Future<bool> GetAllList() async
  {
    video_projects_list.clear();
    var response = await server().Get("panel/all-list",true);
    List all_video=jsonDecode(response)["data"]["videos"]["data"];
    video_projects_list=List<video_project_model>.from(all_video.map((x) => video_project_model.fromjson(x)));
    return true;
  }
  //Get all list end


  //Get submit first step in make video start
  Future<void> Submit_One_Step(var data) async
  {
    var response = await server().Post("video/plan/next",data,true);
    debugPrint("Step one result is  : "+response);
  }
  //Get submit first step in make video end



  //Get all project from server start
  // Future<List<project_model>> GetAllProjects() async
  // {
  //   String resposne=await server().Get("panel/videos",true);
  // }
  //Get all project from server end




}