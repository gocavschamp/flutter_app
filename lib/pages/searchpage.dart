import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var urls = [
    'https://bkimg.cdn.bcebos.com/pic/574e9258d109b3decbdc9fdccdbf6c81800a4c26?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1',
    'https://bkimg.cdn.bcebos.com/pic/562c11dfa9ec8a13b93f2d54f603918fa0ecc059?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1',
    'https://bkimg.cdn.bcebos.com/pic/8ad4b31c8701a18b439a68fb9f2f07082838fe15?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1',
    'https://bkimg.cdn.bcebos.com/pic/023b5bb5c9ea15ceeb4bafbdb7003af33b87b2d9?x-bce-process=image/resize,m_lfit,w_220,h_220,limit_1'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: ListView(
//          scrollDirection:Axis.horizontal ,
          children: urls.map((e) => CachedNetworkImage(imageUrl: e)).toList(),
        ),
//        child: ListView.builder(
//          itemCount: urls.length,
//          scrollDirection:Axis.horizontal ,
//          itemBuilder: (context, index) {
//            return Center(
//
//                child:CachedNetworkImage(
//
//                    imageUrl: urls[index]));
//          },
      ),
    );
  }
}
