
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BaiduPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => _BaiduPageState();
}

class _BaiduPageState extends StatelessWidget {

  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          child: WebView(
            initialUrl: 'https://flutter-io.cn',
            javascriptMode: JavascriptMode.unrestricted,// 支持js
            onWebViewCreated: (WebViewController webViewController) {
//              var complete = _controller.complete(webViewController);//complete(webViewController)
            },
          )
      ),
    );
  }
}