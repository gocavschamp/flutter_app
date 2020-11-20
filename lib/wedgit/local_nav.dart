import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/api/travel_home_bean.dart';
import 'package:flutter_app/wedgit/webview.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LocalNav extends StatelessWidget {
  List<MainItem> _localNavList;

  LocalNav(BuildContext context, @required this._localNavList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: Colors.white,
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _creat(context),
    );
  }

  _creat(BuildContext context) {
    List<Widget> items = [];
    if (_localNavList != null) {
      _localNavList.forEach((element) {
        items.add(_item(context, element));
      });
      return items;
    } else {
      return items;
    }
  }

  Widget _item(BuildContext context, MainItem element) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WebView(url: element.url,
              statusBarColor: element.statusBarColor,
              title: element.title,
              hideAppBar: element.hideAppBar,
              backForbid
              :false);
        }));
      },
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl:
            element.icon,
            height: 32,
            width: 32,
          ),
          Text(
            element.title,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}
