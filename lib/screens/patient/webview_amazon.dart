import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewAmazon extends StatefulWidget {
  @override
  WebviewAmazonState createState() => WebviewAmazonState();
}

class WebviewAmazonState extends State<WebviewAmazon> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl:
          'https://www.amazon.in/s?k=health+and+wellness+products&crid=3N4UNBZESXD6J&sprefix=health+and+wellness+%2Caps%2C436&ref=nb_sb_ss_ts-do-p_1_20',
    );
  }

  WebViewPlatform SurfaceAndroidView() {}
}
