import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NaverWebView extends ConsumerStatefulWidget {
  const NaverWebView({Key? key}) : super(key: key);

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
          webViewController.loadHtmlString(widget.toString());
        },
        onPageFinished: (url) {
          debugPrint(url);
          debugPrint(url.contains('/user/auth/callback?code').toString());
          if (url.contains('/user/auth/callback?code')) {
            _controller
                .runJavascriptReturningResult(
                    "window.document.getElementsByTagName('html')[0].innerText;")
                .then((html) {
              debugPrint(html);
            }).catchError((_) {
              debugPrint("assa");
            });
            // TODO auth viewModel connect
            context.pop();
          }
        },
      ),
    );
  }
}
