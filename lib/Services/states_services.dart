import 'dart:convert';

import 'package:flutter_restapis/Modals/WorldStatesModal.dart';
import 'package:flutter_restapis/Services/Utilities/appurls.dart';
import 'package:http/http.dart' as http;


class StatesServices{

  Future<WorldStatesModal> fetchWorldStatesRecord () async {

    final response = await http.get(Uri.parse(AppUrls.worldStatesData));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatesModal.fromJson(data);
    }
    else{
      throw Exception('ERROR');
    }
  }

  Future<List<dynamic>> countryApiList () async {
    var data;
    final response = await http.get(Uri.parse(AppUrls.countriesApi));
    if(response.statusCode == 200){
       data = jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception('ERROR');
    }
  }
}