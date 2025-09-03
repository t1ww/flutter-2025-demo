import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebView JS Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WebViewWithJS(),
    );
  }
}

class WebViewWithJS extends StatefulWidget {
  const WebViewWithJS({super.key});

  @override
  State<WebViewWithJS> createState() => _WebViewWithJSState();
}

class _WebViewWithJSState extends State<WebViewWithJS> {
  late final WebViewController _controller;
  String totalFromJS = "";

  Future<void> _sendMessage() async {
    await _controller.runJavaScript("updateTotalFromFlutter($totalFromJS)");
  }

  @override
  void initState() {
    super.initState();

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..addJavaScriptChannel(
            'FlutterChannel',
            onMessageReceived: (JavaScriptMessage message) {
              setState(() {
                totalFromJS = message.message;
                _sendMessage();
              });
            },
          )
          ..loadFlutterAsset("assets/challenge_webview.html");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WebView JS Example")),
      body: Column(
        children: [
          Expanded(child: WebViewWidget(controller: _controller)),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey[200],
            width: double.infinity,
            child: Text(
              "Received from JS: $totalFromJS",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

const String htmlContent = """
<!DOCTYPE html>
<html>
<head>
  <title>Shopping Cart</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
  <h1>My Cart
  <p id="total">Total: \$120</p></h1>
  <button style="padding: 16px 32px; font-size: 20px; width: 100%;" onclick="sendTotalToFlutter()">Send Total to Flutter</button>

  <script>
    function sendTotalToFlutter() {
      var totalPrice = document.getElementById('total').innerText;
      FlutterChannel.postMessage(totalPrice);
    }
  </script>
</body>
</html>
""";
