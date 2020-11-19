/// tagId : 401007
/// tagName : "单POI攻略"
/// tagLevel : 2
/// parentTagId : 401000
/// source : 0
/// sortIndex : 0

class Tags {
  int _tagId;
  String _tagName;
  int _tagLevel;
  int _parentTagId;
  int _source;
  int _sortIndex;

  int get tagId => _tagId;
  String get tagName => _tagName;
  int get tagLevel => _tagLevel;
  int get parentTagId => _parentTagId;
  int get source => _source;
  int get sortIndex => _sortIndex;

  Tags({
      int tagId, 
      String tagName, 
      int tagLevel, 
      int parentTagId, 
      int source, 
      int sortIndex}){
    _tagId = tagId;
    _tagName = tagName;
    _tagLevel = tagLevel;
    _parentTagId = parentTagId;
    _source = source;
    _sortIndex = sortIndex;
}

  Tags.fromJson(dynamic json) {
    _tagId = json["tagId"];
    _tagName = json["tagName"];
    _tagLevel = json["tagLevel"];
    _parentTagId = json["parentTagId"];
    _source = json["source"];
    _sortIndex = json["sortIndex"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["tagId"] = _tagId;
    map["tagName"] = _tagName;
    map["tagLevel"] = _tagLevel;
    map["parentTagId"] = _parentTagId;
    map["source"] = _source;
    map["sortIndex"] = _sortIndex;
    return map;
  }

}