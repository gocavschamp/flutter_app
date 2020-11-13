import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/api/travel_home_bean.dart';
import 'package:flutter_app/wedgit/PhotoHero.dart';
import 'package:flutter_app/wedgit/big_pic_nav.dart';
import 'package:flutter_app/wedgit/grid_nav.dart';
import 'package:flutter_app/wedgit/local_nav.dart';
import 'package:flutter_app/wedgit/sub_nav.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var urls = [
    'https://bkimg.cdn.bcebos.com/pic/574e9258d109b3decbdc9fdccdbf6c81800a4c26?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1',
    'https://bkimg.cdn.bcebos.com/pic/562c11dfa9ec8a13b93f2d54f603918fa0ecc059?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1',
    'https://bkimg.cdn.bcebos.com/pic/8ad4b31c8701a18b439a68fb9f2f07082838fe15?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1',
    'https://bkimg.cdn.bcebos.com/pic/023b5bb5c9ea15ceeb4bafbdb7003af33b87b2d9?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1'
  ];

  var _appbarAlphe = 0.0;
  List<MainItem> _localNavList;

  String homeInfo = '';

  GridNavBean _gridNavList;

  List<MainItem> _subNavList;

  List<BannerList> _bannerList;

  SalesBox _salesBox;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (homeInfo.isEmpty) _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: Stack(
            children: [
              NotificationListener(
                onNotification: (scrollListener) {
                  if (scrollListener is ScrollUpdateNotification &&
                      scrollListener.depth == 0) {
                    _onScroll(scrollListener);
                  }
                  return;
                },
                child: _listView,
              ),
              Opacity(
                opacity: _appbarAlphe,
                child: Container(
                    height: 80,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Center(
                      heightFactor: 80,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text('搜索'),
                            Icon(Icons.search)
                          ],
                        ),
                      ),
                    )),
              )
            ],
          )),
    ));
  }

  void _onScroll(ScrollUpdateNotification scrollListener) {
    if (scrollListener.metrics.pixels > 80) {
      setState(() {
        _appbarAlphe = 1.0;
      });
    } else {
      setState(() {
        _appbarAlphe = scrollListener.metrics.pixels / 80;
      });
    }
    print('flutter' + scrollListener.metrics.pixels.toString());
  }

  Future<void> _onRefresh() async {
    TravelHomeBean data = await Apis.getHomeDada();
    setState(() {
      homeInfo = data.toJson().toString();
      _localNavList = data.localNavList;
      _gridNavList = data.gridNav;
      _subNavList = data.subNavList;
      _bannerList = data.bannerList;
      _salesBox = data.salesBox;
    });
    return null;
  }

  Widget get _listView {
    return ListView(
      children: [
        Container(
          color: Colors.grey,
          height: 200,
          child: _banner,
        ),
        Container(
          color: Colors.white,
          child: Padding(
            child: LocalNav(context, _localNavList),
            padding: EdgeInsets.fromLTRB(7, 10, 7, 4),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(_gridNavList),
        ),
        SubNav(context, _subNavList),
        Container(height: 10, color: Color(0x55BDBDBD)),
        Padding(
          padding: EdgeInsets.all(5),
          child: BigPicNav(_salesBox),
        ),
      ],
    );
  }
  Widget get _banner {
    return Swiper(
      itemCount: _bannerList?.length ?? 0,
      autoplay: true,
      pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
              color: Colors.red, activeColor: Colors.green)),
      itemBuilder: (context, index) {
        return PhotoHero(
            photo: _bannerList[index].icon,
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return ListView(
                  children: [
                    Container(
                      height: 300,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: PhotoHero(
                          photo: _bannerList[index].icon,
                          width: 100,
                          onTap: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        height: 300,
                        child: Text(
                          '钢之炼金术师FA',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              backgroundColor: Colors.white),
                        )),
                    Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        height: 400,
                        child: Text(
                          '钢之炼金术师FA',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              backgroundColor: Colors.white),
                        )),
                  ],
                );
              }));
            },
            width: 300.0);
      },
    );
  }

}
