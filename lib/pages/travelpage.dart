import 'package:flutter/material.dart';
import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/api/camera_home_bean.dart';
import 'package:flutter_app/pages/travel_tab_page.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TravelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage>
    with TickerProviderStateMixin {
  final easyRefreshController = EasyRefreshController();

  List<Tabs> tabitems = [];

  CameraHomeBean _data;

  TabController _controller;

  @override
  void initState() {
    _controller = TabController(initialIndex: 0, length: 0, vsync: this);
    Apis.travelHome()
        .then((CameraHomeBean data) {
              _controller = TabController(
                  initialIndex: 0, length: data.tabs.length, vsync: this);
              setState(() {
                tabitems = data.tabs;
                _data = data;
              });
            })
        .catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 30),
          color: Colors.white,
          child: TabBar(
            tabs: tabitems.map<Tab>((e) {
              return Tab(
                text: e.labelName,
              );
            }).toList(),
            controller: _controller,
            labelColor: Colors.black,
            labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                    width: 4, color: Colors.blue, style: BorderStyle.solid),
                insets: EdgeInsets.only(bottom: 10)),
            isScrollable: true,
          ),
        ),
        Flexible(
            child: TabBarView(
          children: tabitems.map((e){
            return TravelTabPage(url:_data.url,patams:_data.params,code: e.groupChannelCode,);
          }).toList(),
          controller: _controller,
        ))
      ],
    ));
  }

  _refresh() {
    return EasyRefresh(
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
        },
        onLoad: () async {
          print("加载完成");
        },
        child: Text(''));
  }


}
