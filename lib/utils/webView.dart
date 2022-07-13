import 'dart:io';

import 'package:climb_balance/providers/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NaverWebView extends ConsumerStatefulWidget {
  final String html;

  const NaverWebView({Key? key, required this.html}) : super(key: key);

  @override
  NaverWebViewState createState() => NaverWebViewState();
}

class NaverWebViewState extends ConsumerState<NaverWebView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'about:blank',
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          _controller.loadUrl('http://54.180.155.137:3000/auth/naver');
        },
        onPageFinished: (url) {
          if (url
              .startsWith('http://54.180.155.137:3000/auth/naver/callback')) {
            _controller
                .runJavascriptReturningResult(
                    "window.document.getElementsByTagName('html')[0].innerText;")
                .then((html) {
              ref
                  .read(tokenProvider.notifier)
                  .updateToken(token: html.split('\\\"')[5]);
              Navigator.popAndPushNamed(context, '/auth/register');
            });
          }
        },
      ),
    );
  }
}
