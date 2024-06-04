
import 'dart:async';
import 'dart:io';

import 'package:e_shop/features/product_details_view/presentation/view/widgets/middle_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../data/repo/api_constance.dart';

class VisaView extends StatefulWidget {
  const VisaView({Key? key}) : super(key: key);

  @override
  State<VisaView> createState() => _VisaViewState();
}

class _VisaViewState extends State<VisaView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: MiddleText(text: "Visa",color: Theme.of(context).primaryColor,fontSize: 25,),
            
            actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: IconButton(
              onPressed: () {
                paymentExitApp(context);
              },
              icon:  Icon(
                Icons.exit_to_app,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        ]),
        body: WebView(
          initialUrl: ApiContest.visaUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }

  // to exit from app
  void paymentExitApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Are you sure completed the pay',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                GoRouter.of(context).go("/");
               
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}