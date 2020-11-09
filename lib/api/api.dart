import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/api/travel_home_bean.dart';

class Apis {
  static const String baseTravelUrl =
      'https://www.devio.org/io/flutter_app/json/';
//      'https://www.devio.org/io/flutter_app/json/home_page.json';
  static const String travel_home = 'home_page.json';

  static Future<TravelHomeBean> getHomeDada() async {
    final response = await http.get(baseTravelUrl + travel_home);
    if (response.statusCode == 200) {
      Utf8Codec utf8codec = Utf8Codec();
     var result = json.decode(utf8codec.decode(response.bodyBytes));
      return TravelHomeBean.fromJson(result);
    } else {
      throw Exception('http failed');
    }
  }
}
