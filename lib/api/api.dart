import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/api/camera_home_bean.dart';
import 'package:flutter_app/api/tab_item_bean.dart';
import 'package:flutter_app/bean/search_result.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/api/travel_home_bean.dart';

class Apis {
  static const String baseTravelUrl =
      'https://www.devio.org/io/flutter_app/json/';

//      'https://www.devio.org/io/flutter_app/json/home_page.json';
  static const String travel_home = 'home_page.json';
  static const String travel_item =
      'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
  static const String search_home =
      'https://m.ctrip.com/restapi/h5api/searchapp/search?contentType=json&keyword=';

 static var params = {
    "districtId": -1,
    "groupChannelCode": "RX-OMF",
    "type": null,
    "lat": -180,
    "lon": -180,
    "locatedDistrictId": 0,
    "pagePara": {
      "pageIndex": 1,
      "pageSize": 10,
      "sortType": 9,
      "sortDirection": 0
    },
    "imageCutType": 1,
   "head": {"cid": "09031014111431397988"},
    "contentType": "json"
  };

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

  static Future<SearchResult> search(String keyword) async {
    final response = await http.get(search_home + keyword);
    if (response.statusCode == 200) {
      Utf8Codec utf8codec = Utf8Codec();
      var result = json.decode(utf8codec.decode(response.bodyBytes));
      SearchResult data = SearchResult.fromJson(result);
      data.keyword = keyword;
      return data;
    } else {
      throw Exception('http failed');
    }
  }

//     Response response;
//     Dio dio = new Dio();
//     response = await dio.get("");
//     print(response.data.toString());
//     FormData formData = new FormData.fromMap({
//       "name": "wendux",
//       "age": 25,
//     });
//   response = await dio.post("", data: formData);
  static Future<CameraHomeBean> travelHome() async {
    Dio dio = new Dio();
    final response = await dio
        .get('http://www.devio.org/io/flutter_app/json/travel_page.json');
    if (response.statusCode == 200) {
      Utf8Codec utf8codec = Utf8Codec();
//      var result = json.decode(utf8codec.decode(response.data));
      CameraHomeBean data = CameraHomeBean.fromJson(response.data);
      return data;
    } else {
      throw Exception('http failed');
    }
  }

  static Future<TabItemBean> travelItem(String url,
      Map params, String groupChannelCode, int pageIndex, int pageSize) async {
    Dio dio = new Dio();
    Map paramsMap = params['pagePara'];
    paramsMap['pageIndex'] = pageIndex;
    paramsMap['pageSize'] = pageSize;
    paramsMap['groupChannelCode'] = groupChannelCode;
    print(paramsMap.toString());
    final response = await dio.post(travel_item, data: paramsMap, );
    if (response.statusCode == 200) {
//      Utf8Codec utf8codec = Utf8Codec();
//      var result = json.decode(utf8codec.decode(response.data));
      TabItemBean data = TabItemBean.fromJson(response.data);
      return data;
    } else {
      throw Exception('http failed');
    }
  }
}
