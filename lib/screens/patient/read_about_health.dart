import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReadAboutHealth extends StatefulWidget {
  @override
  _ReadAboutHealthState createState() => _ReadAboutHealthState();
}

var _urlarray = [
  'https://spectrumhealthcare.com/resources/do-you-know-these-surprising-health-facts/',
  'https://www.thegoodbody.com/health-facts/',
  'https://www.thegoodbody.com/health-facts/',
  'https://www.natgeokids.com/uk/discover/science/general-science/15-facts-about-the-human-body/',
  'https://www.natgeokids.com/uk/discover/science/general-science/15-facts-about-the-human-body/',
  'https://bestlifeonline.com/shocking-health-facts/',
  'https://bestlifeonline.com/shocking-health-facts/',
  'https://spectrumhealthcare.com/resources/do-you-know-these-surprising-health-facts/',
  'https://www.natgeokids.com/uk/discover/science/general-science/15-facts-about-the-human-body/',
  'https://www.thegoodbody.com/health-facts/',
  'https://bestlifeonline.com/shocking-health-facts/'
];

class _ReadAboutHealthState extends State<ReadAboutHealth> {
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: _urlarray[index.nextInt(10)],
    );
  }

  WebViewPlatform SurfaceAndroidView() {}
}

var index = new Random();
