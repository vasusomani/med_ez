import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../Constants/colors.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String exerciseName;

  WebViewScreen({super.key, required this.url, required this.exerciseName});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exerciseName, overflow: TextOverflow.ellipsis),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (_) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(color: appBarColor),
            ),
        ],
      ),
    );
  }
}
