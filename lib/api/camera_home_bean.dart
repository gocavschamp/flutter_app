/// url : "https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5"
/// params : {"districtId":-1,"groupChannelCode":"tourphoto_global1","type":null,"lat":-180,"lon":-180,"locatedDistrictId":2,"pagePara":{"pageIndex":1,"pageSize":10,"sortType":9,"sortDirection":0},"imageCutType":1,"head":{"cid":"09031014111431397988","ctok":"","cver":"1.0","lang":"01","sid":"8888","syscode":"09","auth":null,"extension":[{"name":"protocal","value":"https"}]},"contentType":"json"}
/// tabs : [{"labelName":"推荐","groupChannelCode":"tourphoto_global1"},{"labelName":"端午去哪玩","groupChannelCode":"tab-dwqnw"},{"labelName":"权力的游戏","groupChannelCode":"quanliyouxi"},{"labelName":"创造营2019","groupChannelCode":"chuangzaoyingchaohua"},{"labelName":"比心地球","groupChannelCode":"ycy422"},{"labelName":"拍照技巧","groupChannelCode":"tab-photo"}]

class CameraHomeBean {
  String _url;
  Map _params;
  List<Tabs> _tabs;

  String get url => _url;
  Map get params => _params;
  List<Tabs> get tabs => _tabs;

  CameraHomeBean({
      String url, 
      List<Tabs> tabs}){
    _url = url;
    _tabs = tabs;
}

  CameraHomeBean.fromJson(dynamic json) {
    _url = json["url"];
    _params = json["params"] ;
    if (json["tabs"] != null) {
      _tabs = [];
      json["tabs"].forEach((v) {
        _tabs.add(Tabs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["url"] = _url;
//    if (_params != null) {
//      map["params"] = _params.toJson();
//    }
    if (_tabs != null) {
      map["tabs"] = _tabs.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// labelName : "推荐"
/// groupChannelCode : "tourphoto_global1"

class Tabs {
  String _labelName;
  String _groupChannelCode;

  String get labelName => _labelName;
  String get groupChannelCode => _groupChannelCode;

  Tabs({
      String labelName, 
      String groupChannelCode}){
    _labelName = labelName;
    _groupChannelCode = groupChannelCode;
}

  Tabs.fromJson(dynamic json) {
    _labelName = json["labelName"];
    _groupChannelCode = json["groupChannelCode"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["labelName"] = _labelName;
    map["groupChannelCode"] = _groupChannelCode;
    return map;
  }

}

