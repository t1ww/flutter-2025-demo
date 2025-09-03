import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SimpleWebView());
  }
}

class SimpleWebView extends StatefulWidget {
  const SimpleWebView({Key? key}) : super(key: key);

  @override
  State<SimpleWebView> createState() => _SimpleWebViewState();
}

class _SimpleWebViewState extends State<SimpleWebView> {
  late final WebViewController _controller1;
  late final WebViewController _controller2;

  @override
  void initState() {
    super.initState();
    // First controller for asset
    _controller1 = WebViewController()..loadFlutterAsset('assets/index.html');

    // Second controller for HTML string
    _controller2 =
        WebViewController()..loadHtmlString(
          '<html><body><h1>HTML String Content</h1><p>This is loaded from a string</p></body></html>',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter WebView')),
      body: Column(
        children: [
          Expanded(child: WebViewWidget(controller: _controller1)),
          const Divider(thickness: 2, height: 1),
          Expanded(child: WebViewWidget(controller: _controller2)),
        ],
      ),
    );
  }
}
