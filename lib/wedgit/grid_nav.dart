import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/travel_home_bean.dart';
import 'package:flutter_app/wedgit/webview.dart';

class GridNav extends StatelessWidget {
  final GridNavBean data;

  const GridNav(@required this.data);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (data == null) return items;
    if (data.hotel != null) {
      items.add(_gridItem(context, data.hotel, true));
    }
    if (data.flight != null) {
      items.add(_gridItem(context, data.flight, false));
    }
    if (data.travel != null) {
      items.add(_gridItem(context, data.travel, false));
    }
    return items;
  }

  Widget _gridItem(BuildContext context, Hotel model, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, model.mainItem));
    items.add(_doubleItem(context, model.item1, model.item2));
    items.add(_doubleItem(context, model.item3, model.item4));
    List<Widget> expandItems = [];
    items.forEach((element) {
      expandItems.add(Expanded(
        child: element,
        flex: 1,
      ));
    });

    Color starColor = Color(int.parse('0xff' + model.startColor));
    Color endColor = Color(int.parse('0xff' + model.endColor));
    List<Color> colors = [];
    colors.add(starColor);
    colors.add(endColor);
    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(gradient: LinearGradient(colors: colors)),
      child: Row(
        children: expandItems,
      ),
    );
  }

  Widget _mainItem(BuildContext context, MainItem item) {
    return _wrapGesture(
        context,
        Stack(
          children: [
            CachedNetworkImage(
              imageUrl:
              item.icon,
              height: 88,
              width: 121,
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                item.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ],
          alignment: AlignmentDirectional.topCenter,
        ),
        item);
  }

  Widget _doubleItem(BuildContext context, MainItem top, MainItem bootm) {
    return Column(
      children: [
        Expanded(child: _item(context, top, true)),
        Expanded(child: _item(context, bootm, false)),
      ],
    );
  }

  Widget _wrapGesture(BuildContext context, Widget widget, MainItem element) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return WebView(element.url, element.statusBarColor, element.title,
                element.hideAppBar, false);
          }));
        },
        child: widget);
  }

  _item(BuildContext context, MainItem item1, bool first) {
    BorderSide borderSide = BorderSide(color: Colors.white, width: 1);
    return FractionallySizedBox(
      //撑满父布局宽度
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              left: borderSide, bottom: first ? borderSide : BorderSide.none),
        ),
        child: Container(
          child: _wrapGesture(
              context,
              Center(
                child: Text(
                  item1.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              item1),
        ),
      ),
    );
  }
}
