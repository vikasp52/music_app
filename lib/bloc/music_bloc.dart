import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:musicapp/model/music_model.dart';


class MusicBloc {
  static const BASE_URL =
      "http://rss.itunes.apple.com/api/v1/in/apple-music/new-releases/all/100/non-explicit.json";

  Future<MusicModel> getMusicData()async{
    var response = await http.get(BASE_URL);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      int resultLength = jsonResponse.length;
      print("Market list: $jsonResponse");
      MusicModel regModel = MusicModel.fromJson(jsonResponse);
      print('regModel: ${regModel.resultList[0].artistName}');
      return regModel;
    }else{
      print('There is some problem');
    }
    return null;
  }
}

MusicBloc musicBloc = MusicBloc();