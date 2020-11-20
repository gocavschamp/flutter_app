import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/api/tab_item_bean.dart';
import 'package:flutter_app/utils/navigator_util.dart';
import 'package:flutter_app/wedgit/webview.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TravelTabPage extends StatefulWidget {
  final String url;
  final Map patams;
  final String code;

  const TravelTabPage({Key key, this.url, this.patams, this.code})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TravelTabPageState();
}

class TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController easyRefreshController;
  int _pageIndex = 1;
  int _pageSize = 10;

  List<ResultList> _datas = [];

  @override
  void initState() {
    easyRefreshController = EasyRefreshController();
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: EasyRefresh(
          controller: easyRefreshController,
          enableControlFinishRefresh: false,
          enableControlFinishLoad: false,
          header: ClassicalHeader(
              textColor: Colors.black87,
              refreshText: "往下拉，往下拉",
              refreshedText: "刷新完成",
              refreshingText: "正在刷新",
              refreshReadyText: "快放手"),
          footer: ClassicalFooter(
              textColor: Colors.black87,
              loadText: "往上拉，往上拉",
              loadedText: "加载完成",
              loadingText: "正在加载",
              loadReadyText: "快放手"),
          onRefresh: () async {
            print("刷新完成");
            loadData();
          },
          onLoad: () async {
            print("加载完成");
            loadData(loadMore: true);
          },
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: _datas?.length ?? 0,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () {
                NavigatorUtil.push(
                    context,
                    WebView(
                      url: _datas[index].article.urls[0].h5Url,
                    ));
              },
              child: Container(
                color: Colors.white,
                child: new Card(
                  clipBehavior: Clip.antiAlias,
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  shadowColor: Colors.grey,
                  child: Column(
                    children: [
                      _topImage(index),
                      Container(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          _datas[index].article.articleTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                      _bottomInfo(index),
                    ],
                  ),
                ),
              ),
            ),

            staggeredTileBuilder: (int index) => new StaggeredTile.fit(
              2,
            ),
//            mainAxisSpacing: 4.0,
//            crossAxisSpacing: 4.0,
          )),
    );
  }

  void loadData({loadMore = false}) {
    loadMore ? _pageIndex++ : _pageIndex = 1;
    Apis.travelItem(
            widget.url, widget.patams, widget.code, _pageIndex, _pageSize)
        .then((TabItemBean data) {
      setState(() {
        !loadMore ? _datas = data.resultList : _datas.addAll(data.resultList);
//        print(data.toJson().toString());
      });
      loadMore
          ? easyRefreshController.finishLoad(success: true, noMore: false)
          : easyRefreshController.finishRefresh(success: true);
    }).catchError((e) {
      print(e);
      easyRefreshController.finishLoad(success: false, noMore: false);
    });
  }

  @override
  bool get wantKeepAlive => true;

  String _poiName(int index) {
    return _datas[index].article.poiName ?? '未知';
  }

  _topImage(int index) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: _datas[index].article.images[0]?.dynamicUrl,
          placeholder: (context, url) => Container(
            height: 160,
            color: Colors.white60,
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
        Positioned(
            left: 8,
            bottom: 8,
            child: Container(
              color: Colors.black12,
              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                  LimitedBox(
                    maxWidth: 130,
                    child: Text(
                      _poiName(index),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  _bottomInfo(int index) {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  _datas[index].article.author?.coverImage?.dynamicUrl,
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: 90,
                child: Text(
                  _datas[index].article.author?.nickName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  _datas[index].article.likeCount.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
