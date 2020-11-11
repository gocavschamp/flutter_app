import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebView extends StatefulWidget {
  String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView(this.url, this.statusBarColor, this.title, this.hideAppBar,
      this.backForbid);

  @override
  State<StatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  bool isLoad = true;

  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;

  @override
  void initState() {
    super.initState();
    webviewReference.close();
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {});
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.finishLoad:
          setState(() {
            isLoad = false;
          });
          break;
        case WebViewState.startLoad:
          webviewReference.launch(widget.url);
          setState(() {
            isLoad = true;
          });
          break;
        default:
          break;
      }
    });
    _onHttpError =
        webviewReference.onHttpError.listen((WebViewHttpError error) {
      print(error);
    });
  }

  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  void dispose() {
    _onStateChanged.cancel();
    _onUrlChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
        body: WebviewScaffold(
      appBar: _appBar(
          Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
      url: widget.url,
      withLocalStorage: true,
      withJavascript: true,
      scrollBar: false,
    ));
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if(widget.hideAppBar??false)
      return new PreferredSize(
        child: SizedBox(
          height: 30,
          child:  Container(color: backgroundColor,),
        ),
        preferredSize: Size.fromHeight(1),
      );
      else
    return AppBar(
      elevation: 0.4,
      title: new Text(
        widget.title,
        style: TextStyle(color: backButtonColor, fontSize: 20),
      ),
      bottom: new PreferredSize(
        child: SizedBox(
          height: 2,
          child: isLoad ? new LinearProgressIndicator() : Container(),
        ),
        preferredSize: Size.fromHeight(2),
      ),
      actions: <Widget>[
        IconButton(
          // tooltip: '用浏览器打开',
          icon: Icon(
            Icons.close,
            size: 20.0,
            color: backButtonColor,
          ),
          onPressed: () {
            Navigator.pop(context);
//            RouteUtil.launchInBrowser(widget.url, title: widget.title);
          },
        ),
        IconButton(
          // tooltip: '分享',
          icon: Icon(
            Icons.share,
            size: 20.0,
            color: backButtonColor,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
