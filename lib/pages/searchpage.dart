import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/bean/search_result.dart';
import 'package:flutter_app/utils/navigator_util.dart';
import 'package:flutter_app/wedgit/search_bar.dart';
import 'package:flutter_app/wedgit/webview.dart';

class SearchPage extends StatefulWidget {
  SearchType type;
  String defaultSearch;

  SearchPage({this.type = SearchType.normal, this.defaultSearch});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Data> _list;

  SearchResult _data;

  List<TextSpan> _item(String word) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) return spans;
    //搜索关键字高亮忽略大小写
    String wordL = word.toLowerCase(), keywordL = _data.keyword.toLowerCase();
    List<String> arr = wordL.split(keywordL);
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    //'wordwoc'.split('w') -> [, ord, oc] @https://www.tutorialspoint.com/tpcg.php?p=wcpcUA
    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
        //搜索关键字高亮忽略大小写
        preIndex = wordL.indexOf(keywordL, preIndex);
        spans.add(TextSpan(
            text: word.substring(preIndex, preIndex + keywordL.length),
            style: keywordStyle));
      }
      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.defaultSearch != null && widget.defaultSearch.length > 0) {
      _search(widget.defaultSearch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            height: 80,
            child: SearchBar(
              showBack: false,
              defaultText: '',
              type: widget.type,
              onchange: _onTextChange,
              speakClick: () {},
            ),
          ),
          MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10),
                  itemCount: _list?.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        NavigatorUtil.push(
                            context,
                            WebView(_list[index].url, '', _list[index].word,
                                false, true));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey))),
                        padding: EdgeInsets.all(5),
                        child: RichText(
                          text: TextSpan(children: _item(_list[index].word)),
                        ),
//                        Text(
//                          _list[index].word,
//                          style: TextStyle(color: Colors.lightBlue),
//                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  void _onTextChange(String value) {
    print(value);
    if (value.isNotEmpty) {
      _search(value);
    } else {
      setState(() {
        _list = null;
      });
    }
  }

  _search(String word) {
    Apis.search(word).then((value) {
      _data = value;
      if (word == value.keyword)
        setState(() {
          _list = value.data;
        });
    });
  }
}
