import 'package:flutter/material.dart';
import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/api/tab_item_bean.dart';
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
//    loadData();
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
            itemCount: _datas.length,
            itemBuilder: (BuildContext context, int index) => new Container(
                color: Colors.green,
                child: new Center(
                  child: new CircleAvatar(
                    backgroundColor: Colors.white,
                    child: new Text(_datas[index].article?.articleTitle),
                  ),
                )),
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          )),
    );
  }

  void loadData({loadMore = false}) {
    Apis.travelItem(Apis.params, widget.code, _pageIndex, _pageSize)
        .then((TabItemBean data) {
      setState(() {
        _datas = data.resultList;
        loadMore
            ? easyRefreshController.finishLoad(success: true, noMore: false)
            : easyRefreshController.finishRefresh(success: true);
      });
    }).catchError((e) {
      print(e);
      easyRefreshController.finishLoad(success: false, noMore: false);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
