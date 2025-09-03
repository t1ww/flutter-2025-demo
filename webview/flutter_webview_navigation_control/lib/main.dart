import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  @override
  _NavigationExampleState createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  late final WebViewController _controller;
  bool _isLoading = false;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                print("Page started loading: $url");
                setState(() {
                  _isLoading = true;
                  _progress = 0.0;
                });
              },
              onProgress: (progress) {
                print("Loading progress: $progress%");
                setState(() {
                  _progress = progress / 100;
                });
              },
              onPageFinished: (url) {
                print("Page finished loading: $url");
                setState(() {
                  _isLoading = false;
                  _progress = 1.0;
                });
              },
              onNavigationRequest: (request) {
                if (request.url.startsWith("https://flutter.dev") ||
                    request.url.startsWith("https://docs.flutter.dev")) {
                  return NavigationDecision.navigate;
                }
                print("Blocked navigation to: ${request.url}");
                return NavigationDecision.prevent;
              },
            ),
          )
          ..loadRequest(Uri.parse("https://flutter.dev"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView Navigation & Events"),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              if (await _controller.canGoBack()) {
                _controller.goBack();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () async {
              if (await _controller.canGoForward()) {
                _controller.goForward();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _controller.reload(),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),

          // Progress bar
          if (_progress > 0.0 && _progress < 1.0)
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),

          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
