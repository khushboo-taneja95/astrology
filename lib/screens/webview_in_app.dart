import 'package:flutter/material.dart';
import 'package:login/widgets/toolbar_with_title_and_back_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewInApp extends StatefulWidget {
  final String toolbarTitle;
  final String pageURL;
  const WebviewInApp(
      {Key? key, required this.toolbarTitle, required this.pageURL})
      : super(key: key);

  @override
  State<WebviewInApp> createState() => _WebviewInAppState();
}

class _WebviewInAppState extends State<WebviewInApp> {
  bool _isPageLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ToolbarWithTitleAndBackbutton(title: widget.toolbarTitle),
            Expanded(
              child: Stack(
                children: <Widget>[
                  WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: widget.pageURL,
                    onPageFinished: (finish) {
                      debugPrint('ON PAGED FINISHED IS CALLED');
                      setState(() {
                        _isPageLoading = false;
                      });
                    },
                  ),
                  Visibility(
                    visible: _isPageLoading,
                    child: const Center(
                      child: CircularProgressIndicator(
                          color: Color(0xffFE7A36),
                        ),
                    ),
                  ),
                      
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
