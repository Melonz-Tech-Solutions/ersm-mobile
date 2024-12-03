// @dart=2.9
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zamboangaemergency/default/config.dart';

class DetailedGuideScreen extends StatefulWidget {
  final dynamic details;

  DetailedGuideScreen({Key key, this.details}) : super(key: key);
  @override
  _DetailedGuideScreenState createState() => _DetailedGuideScreenState();
}

class _DetailedGuideScreenState extends State<DetailedGuideScreen> {
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  PageController _pageController =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    // final _pages = List.generate(widget.details['pages'], (index) => ;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ScaffoldMessenger(
          key: _scaffoldKey,
          child: SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 2 * Config.heightMultiplier),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.details['text'].toString().toUpperCase(),
                        textScaleFactor: .8,
                        style: TextStyle(
                            fontSize: Config.header * Config.textMultiplier,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        // child: Image(image: AssetImage('${widget.details['prefix']}${widget.details['images'][_index]}'))
                        child: PageView(controller: _pageController,
                            // itemCount: pages.length,
                            children: [
                              for (dynamic image in widget.details['images'])
                                PhotoView(
                                    imageProvider: AssetImage(
                                        '${widget.details['prefix']}${image}'),
                                    minScale: .08 * Config.imageSizeMultiplier,
                                    initialScale:
                                        .08 * Config.imageSizeMultiplier,
                                    backgroundDecoration: BoxDecoration(
                                        color: Colors.transparent))
                            ]),
                      ),
                      if (widget.details['pages'] > 1)
                        Align(
                            alignment: Alignment.center,
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: widget.details['pages'],
                              effect: WormEffect(),
                            ))
                    ],
                  ))),
        ));
  }
}
