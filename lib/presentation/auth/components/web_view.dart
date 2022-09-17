import 'dart:io';

import 'package:climb_balance/presentation/auth/auth_view_model.dart';
import 'package:flutter/material.dart';
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
          webViewController
              .loadUrl(ref.read(authViewModelProvider.notifier).getAuthUrl());
          _controller = webViewController;
        },
        onPageFinished: (url) {
          if (url.contains('/user/auth/callback?code')) {
            ref
                .read(authViewModelProvider.notifier)
                .authComplete(_controller, context);
          }
        },
      ),
    );
  }
}
