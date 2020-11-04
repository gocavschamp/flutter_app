import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<String> urls = [
    'https://bkimg.cdn.bcebos.com/pic/574e9258d109b3decbdc9fdccdbf6c81800a4c26?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1',
    'https://bkimg.cdn.bcebos.com/pic/562c11dfa9ec8a13b93f2d54f603918fa0ecc059?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1',
    'https://bkimg.cdn.bcebos.com/pic/8ad4b31c8701a18b439a68fb9f2f07082838fe15?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1',
    'https://bkimg.cdn.bcebos.com/pic/023b5bb5c9ea15ceeb4bafbdb7003af33b87b2d9?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1',
    'https://bkimg.cdn.bcebos.com/pic/574e9258d109b3decbdc9fdccdbf6c81800a4c26?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1',
    'https://bkimg.cdn.bcebos.com/pic/562c11dfa9ec8a13b93f2d54f603918fa0ecc059?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1',
    'https://bkimg.cdn.bcebos.com/pic/8ad4b31c8701a18b439a68fb9f2f07082838fe15?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1',
    'https://bkimg.cdn.bcebos.com/pic/023b5bb5c9ea15ceeb4bafbdb7003af33b87b2d9?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1',
  ];
  ScrollController _scrollController = ScrollController();

  bool _showLoading = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _showLoading = true;
        });
        loadMore();
        Toast.show('加载中。。。', context,gravity: Toast.BOTTOM);

      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('下拉刷新'),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
//          child: Column(
//            children: [
//              ListView(
//                controller: _scrollController,
////          scrollDirection:Axis.horizontal ,
//                children:
//                    urls.map((e) => CachedNetworkImage(imageUrl: e)).toList(),
//              ),
          child: ListView.builder(
              itemCount: urls.length,
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Center(child: _item(index));

//            ],
              }),
        ));
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      urls = urls.take(5);
    });
    return null;
  }

  loadMore() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _showLoading = false;
      List<String> add = List<String>.from(urls);
      add.addAll(urls);
      urls = add;
    });
  }

  _item(int index) {
//    if (index == urls.length - 1) {
//      return Column(
//        children: [
//          CachedNetworkImage(imageUrl: urls[index]),
//          Offstage(
//              offstage: _showLoading,
//              child: Center(
//                child: Text('加载中。。。'),
//              )),
//        ],
//      );
//    } else {
      return CachedNetworkImage(imageUrl: urls[index]);
//    }
  }
}
