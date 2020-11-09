import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/api.dart';
import 'package:flutter_app/api/travel_home_bean.dart';
import 'package:flutter_app/wedgit/PhotoHero.dart';
import 'package:flutter_app/wedgit/local_nav.dart';
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

  String homeInfo = '首页';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
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
                child: ListView(
                  children: [
                    Container(
                      color: Colors.grey,
                      height: 200,
                      child: Swiper(
                        itemCount: urls.length,
                        autoplay: true,
                        pagination: SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                                color: Colors.red, activeColor: Colors.green)),
                        itemBuilder: (context, index) {
                          return PhotoHero(
                              photo: urls[index],
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
                                            photo: urls[index],
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
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child:
                      Padding(
                       child: LocalNav(context,_localNavList),
                        padding: EdgeInsets.fromLTRB(7, 10, 7, 4),

                      ),
                    )
                  ],
                ),
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
                          verticalDirection: VerticalDirection.up,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(homeInfo),
                            Text('搜索'),
                            Icon(Icons.search)
                          ],
                        ),
                      ),
                    )),
              )
            ],
          )),
    );
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

  void loadData() async {
    TravelHomeBean data = await Apis.getHomeDada();
    setState(() {
      homeInfo = data.toJson().toString();
      _localNavList = data.localNavList;
    });
  }
}
