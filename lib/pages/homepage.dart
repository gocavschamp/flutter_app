import 'package:flutter/material.dart';
import 'package:flutter_app/wedgit/PhotoHero.dart';
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
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 170,
              child: Swiper(
                itemCount: urls.length,
                autoplay: true,
                pagination: SwiperPagination(),
                itemBuilder: (context, index) {
                  return PhotoHero(
                      photo: urls[index],
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Column(
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
                              Text(
                                '钢之炼金术师FA',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    backgroundColor: Colors.white),
                              )
                            ],
                          );
                        }));
                      },
                      width: 300.0);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
