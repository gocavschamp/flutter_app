import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/travel_home_bean.dart';
import 'package:flutter_app/utils/navigator_util.dart';
import 'package:flutter_app/wedgit/webview.dart';

class BigPicNav extends StatelessWidget {
  final SalesBox _salesBox;

  const BigPicNav(this._salesBox);

  @override
  Widget build(BuildContext context) {
    return creat(context);
  }

  Widget _wrapGesture(BuildContext context, Widget widget, MainItem element) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return  WebView(url: element.url,
                statusBarColor: element.statusBarColor,
                title: element.title,
                hideAppBar: element.hideAppBar,
                backForbid
                    :false);
          }));
        },
        child: widget);
  }

  Widget creat(BuildContext context) {
    List<MainItem> list1 = [];
    List<MainItem> list2 = [];

    if (_salesBox == null) {
      return Column(
        children: [
          Container(
            height: 300,
          )
        ],
      );
    } else {
      list1.add(_salesBox.bigCard1);
      list1.add(_salesBox.bigCard2);
      list2.add(_salesBox.smallCard1);
      list2.add(_salesBox.smallCard2);
      list2.add(_salesBox.smallCard3);
      list2.add(_salesBox.smallCard4);
      List<Widget> items = [];
      items.add(_doubleItem(
          context, _salesBox.bigCard1, _salesBox.bigCard2, true, false));
      items.add(_doubleItem(
          context, _salesBox.smallCard1, _salesBox.smallCard2, false, false));
      items.add(_doubleItem(
          context, _salesBox.smallCard3, _salesBox.smallCard4, false, true));
      return Container(
        color: Colors.white,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WebView(url:_salesBox.moreUrl, title: '福利',);
                  }));
                },
                child: Container(
                    height: 30,
                    padding: EdgeInsets.only(left: 5),
                    alignment: AlignmentDirectional.centerStart,
                    child: CachedNetworkImage(
                      imageUrl: _salesBox?.icon ?? '',
                      height: 20,
                      width: 80,
                      fit: BoxFit.fill,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WebView(url:_salesBox.moreUrl, title: '福利',);
                  }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 25,
                  padding: EdgeInsets.all(5),
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    '查看更多福利 >',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
//            _creatIem(context, list1),
//            _creatIem(context, list2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(0, 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(1, 2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(2, 3),
          )
        ]),
      );
    }
  }

  _creatItem(BuildContext context, List<MainItem> data) {
    return Row();
  }

  _creatIem(BuildContext context, List<MainItem> data) {
    return GridView.builder(
      itemCount: data.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        childAspectRatio: data.length > 2 ? 2.3 : 1.4,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WebView(url:data[index].url, statusBarColor:data[index].statusBarColor,
                    title:data[index].title, hideAppBar:data[index].hideAppBar, );
              }));
            },
            child: Container(
              alignment: Alignment.center,
              child: Expanded(
                flex: 1,
                child: Image.network(
                  data[index].icon,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width / 2 - 5,
                ),
              ),
            ));
      },
    );
  }

  Widget _doubleItem(BuildContext context, MainItem leftCard,
      MainItem rightCard, bool big, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _item(context, leftCard, big, true, last),
        _item(context, rightCard, big, false, last)
      ],
    );
  }

  Widget _item(
      BuildContext context, MainItem model, bool big, bool left, bool last) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Color(0xfff2f2f2));
    return GestureDetector(
        onTap: () {
          NavigatorUtil.push(
              context,
              WebView(
                url:model.url,
                statusBarColor:model.statusBarColor,
                title: model.title,
                hideAppBar:model.hideAppBar,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  right: left ? borderSide : BorderSide.none,
                  bottom: last ? BorderSide.none : borderSide)),
          child: CachedNetworkImage(
            imageUrl: model.icon,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width / 2 - 10,
            height: big ? 129 : 80,
          ),
        ));
  }
}
