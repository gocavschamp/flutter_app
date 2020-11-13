import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/api/travel_home_bean.dart';
import 'package:flutter_app/wedgit/webview.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class SubNav extends StatelessWidget {
  List<MainItem> _localNavList;

  SubNav(BuildContext context, this._localNavList);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    return GridView.count(
      //水平子Widget之间间距
//      crossAxisSpacing: 10.0,
      //垂直子Widget之间间距
//      mainAxisSpacing: 10.0,
      physics:  NeverScrollableScrollPhysics(),
      //GridView内边距
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(8.0),
      //一行的Widget数量
      crossAxisCount: 5,
      shrinkWrap: true,
      //子Widget宽高比例
      childAspectRatio: 1.3,
      //子Widget列表
      children: _creat(context),
    );
  }

  _creat(BuildContext context) {
    List<Widget> items = [];
    if (_localNavList == null || _localNavList?.length == 0) {
      return items;
    } else {
      _localNavList.forEach((element) {
        items.add(_item(context, element));
      });
//    List<Widget> list = items.sublist(0,(items.length/2).toInt());
//    return list;
      return items;
    }
  }

  Widget _item(BuildContext context, MainItem element) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return WebView(element.url, element.statusBarColor, element.title,
                element.hideAppBar, false);
          }));
        },
        child: Container(
//          color: Colors.red,
            alignment: Alignment.center,
            child: Center(
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                    element.icon,
                    height: 18,
                    width: 18,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      element.title,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                ],
              ),
            )));
  }
}
