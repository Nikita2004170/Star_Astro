import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


@RoutePage()
class StripeWebView extends StatefulWidget {
  const StripeWebView({super.key, required this.url});

  final String url;

  @override
  State<StripeWebView> createState() => _StripeWebViewState();
}

class _StripeWebViewState extends State<StripeWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            log("onProgress : $progress");
          },
          onPageStarted: (String url) {
            log("onPageStarted : $url");
          },
          onPageFinished: (String url) async {
            log("onPageFinished : $url");
            if (url == 'https://app.starastro.ai/cancel') {
              Navigator.pop(context);
              return;
            }
            Uri uri = Uri.parse(url);
            String? sessionId = uri.queryParameters['session_id'];
            if (sessionId != null) {
              Navigator.pop(context, sessionId);
            }
          },
          onHttpError: (HttpResponseError error) {
            log("onHttpError : $error");
          },
          onWebResourceError: (WebResourceError error) {
            log("onWebResourceError : ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: _controller,
        ),
      ),
    );
  }
}
