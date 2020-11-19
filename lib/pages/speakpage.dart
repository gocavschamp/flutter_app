import 'package:flutter/material.dart';
import 'package:flutter_app/pages/searchpage.dart';
import 'package:flutter_app/plugin/asr_manager.dart';
import 'package:flutter_app/utils/navigator_util.dart';

class SpeakPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpeakPageState();
}

const double MIC_SIZE = 80.0;

class _SpeakPageState extends State<SpeakPage>
    with SingleTickerProviderStateMixin {
  String speakResult = '111';
  String _tipInfo = '按住说话';
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('语音搜索'),
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                        child: Text('你可以这样说',
                            style: TextStyle(
                                fontSize: 16, color: Colors.black54))),
                    Text('故宫门票\n北京一日游\n迪士尼乐园',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        )),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        speakResult,
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: GestureDetector(
                    onTapDown: (e) {
                      controller.forward();
                      _speakStart();
                    },
                    onTapUp: (e) {
                      controller.reset();
                      controller.stop();
                      _speakStop();
                    },
                    onTapCancel: () {
                      controller.reset();
                      controller.stop();
                      _speakStop();
                    },
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Text(
                              _tipInfo,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue),
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: MIC_SIZE,
                                  width: MIC_SIZE,
                                ),
                                Center(
                                  child: AnimateMic(
                                    animation: animation,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Positioned(
                          right: 0,
                            top: 30,
                            child: Icon(
                          Icons.close,
                          color: Colors.blue,
                          size: 30,
                        ))
                      ],
                    ),
                  ),
                )
              ],
            )));
  }

  loadMore() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  void _speakStart() {
    setState(() {
      _tipInfo = '- 识别中 -';
    });
    AsrManager.start().then((value) => () {
              if (value != null && value.length > 0) {
                setState(() {
                  speakResult = value;
                });
                print('-----'+value);
                Navigator.pop(context);
                NavigatorUtil.push(
                    context,
                    SearchPage(
                      defaultSearch: value,
                    ));
              }
            })
        .catchError((e) {
      print('------'+e.toString());
    });
  }

  void _speakStop() {
    setState(() {
      _tipInfo = '按住说话';
    });
    AsrManager.stop();
  }
}

class AnimateMic extends AnimatedWidget {
    Tween<double> _opacityTween = Tween<double>(begin: 1.0, end: 0.5);
    Tween<double> _sizeTween = Tween<double>(begin: MIC_SIZE, end: MIC_SIZE - 25);

  AnimateMic({
    Key key,
    Animation<double> animation
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        height: _sizeTween.evaluate(animation),
        width: _sizeTween.evaluate(animation),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(MIC_SIZE / 2)),
        child: Icon(
          Icons.mic,
          color: Colors.white,
        ),
      ),
    );
  }
}
