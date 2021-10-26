import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  final String sauce;
  const NewsWebView({Key? key, required this.sauce}) : super(key: key);

  @override
  _NewsWebViewState createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color(0xFF111111),
      body: WebView(
        initialUrl: widget.sauce,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
