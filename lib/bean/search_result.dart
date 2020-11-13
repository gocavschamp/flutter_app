/// data : [{"word":"大水泊机场附近的酒店","type":"airporthotel","districtname":"","url":"ctrip://wireless/hotel_inland_list?c1=20201113&c2=20201114&c3=479&c9=2&c10=37.51306915283203&c11=122.12042236328125&c14=%E5%A4%A7%E6%B0%B4%E6%B3%8A%E6%9C%BA%E5%9C%BA&c16=5"},{"word":"大西洋城国际机场附近的酒店","type":"airporthotel","districtname":"","url":"ctrip://wireless/hotel_oversea_list?c1=20201113&c2=20201114&c3=4261&c5=1&c9=2&c10=39.36428451538086&c11=-74.42292785644531&c14=%E5%A4%A7%E8%A5%BF%E6%B4%8B%E5%9F%8E%E5%9B%BD%E9%99%85%E6%9C%BA%E5%9C%BA&c16=5"},{"word":"奄美大岛机场附近的酒店","type":"airporthotel","districtname":"","url":"ctrip://wireless/hotel_oversea_list?c1=20201113&c2=20201114&c3=93076&c5=1&c9=2&c10=28.377248764038086&c11=129.49374389648438&c14=%E5%A5%84%E7%BE%8E%E5%A4%A7%E5%B2%9B%E6%9C%BA%E5%9C%BA&c16=5"}]

class SearchResult {
  List<Data> _data;

  List<Data> get data => _data;

  SearchResult({
      List<Data> data}){
    _data = data;
}

  SearchResult.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// word : "大水泊机场附近的酒店"
/// type : "airporthotel"
/// districtname : ""
/// url : "ctrip://wireless/hotel_inland_list?c1=20201113&c2=20201114&c3=479&c9=2&c10=37.51306915283203&c11=122.12042236328125&c14=%E5%A4%A7%E6%B0%B4%E6%B3%8A%E6%9C%BA%E5%9C%BA&c16=5"

class Data {
  String _word;
  String _type;
  String _districtname;
  String _url;

  String get word => _word;
  String get type => _type;
  String get districtname => _districtname;
  String get url => _url;

  Data({
      String word, 
      String type, 
      String districtname, 
      String url}){
    _word = word;
    _type = type;
    _districtname = districtname;
    _url = url;
}

  Data.fromJson(dynamic json) {
    _word = json["word"];
    _type = json["type"];
    _districtname = json["districtname"];
    _url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["word"] = _word;
    map["type"] = _type;
    map["districtname"] = _districtname;
    map["url"] = _url;
    return map;
  }

}