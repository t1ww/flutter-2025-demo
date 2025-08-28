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
      home: const FlutterToJSExample(),
    );
  }
}

class FlutterToJSExample extends StatefulWidget {
  const FlutterToJSExample({super.key});

  @override
  State<FlutterToJSExample> createState() => _FlutterToJSExampleState();
}

class _FlutterToJSExampleState extends State<FlutterToJSExample> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadHtmlString(htmlContent);
  }

  Future<void> _sendMessage() async {
    // Option 1: Just run JS, no return value
    await _controller.runJavaScript("showMessageFromFlutter('Hello from Flutter!')");

    // Option 2: Get return value from JS
    final result = await _controller.runJavaScriptReturningResult(
      "showMessageFromFlutter('Hello from Flutter with return value!')",
    );
    debugPrint("JS returned: $result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter to JS"),
        actions: [IconButton(icon: const Icon(Icons.send), onPressed: _sendMessage)],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

const String htmlContent = """
<!DOCTYPE html>
<html>
<head>
  <title>JS from Flutter</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
  <h1>Web Page</h1>
  <p id="msg">No message yet</p>

  <script>
    function showMessageFromFlutter(msg) {
      document.getElementById('msg').innerText = "Flutter says: " + msg;
      return "Message received: " + msg;
    }
  </script>
</body>
</html>
""";
