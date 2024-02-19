import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mafatih/videos/data/data.dart';

class server
{

  //global variables
  String ROOT="https://www.arbaeentv.com/api/v1/";
  String token="15|513csRNHOFJidVSYrItGuQHnDiC9NWE4WdJsnpKe";


  //Get ftech sata from server start
  Future<String> Get(String Address,bool auth) async
  {
    if(auth)
    {
      var response = await http.get(Uri.parse(ROOT + Address),headers: { "Authorization":"Bearer "+token ,"Accept":"application/json"});
      return response.body.toString();
    }
    else
    {
      var response = await http.get(Uri.parse(ROOT + Address),headers: {"Accept":"application/json"});
      return response.body.toString();
    }
  }
  //Get ftech sata from server end


  //Get ftech sata from server start
  Future<String> Post(String Address,Map<String,String> data,bool auth) async
  {
    if(auth)
    {
      var response = await http.post(Uri.parse(ROOT + Address),body: data,headers: { "Authorization":"Bearer "+token ,"Accept":"application/json"});
      return response.body.toString();
    }
    else
    {
      var response = await http.post(Uri.parse(ROOT + Address),headers: {"Accept":"application/json"},body: data);
      return response.body.toString();
    }
  }
  //Get ftech sata from server end


}