import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store/modules/login.dart';
import 'package:store/shared/network/local/cache_helper.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<String> images = [
    'images/1.png',
    'images/2.png',
  ];

  List<String> titles = [
    'Welcome',
    'Get every thing you need',
  ];

  var pageController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                if (index == images.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  isLast = false;
                }
              },
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image(
                      image: AssetImage('${images[index]}'),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          '${titles[index]}',
                          style: TextStyle(
                              fontSize: 35.0, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              physics: BouncingScrollPhysics(),
              controller: pageController,
              itemCount: images.length,
            ),
          ),
          Row(
            children: [
              SmoothPageIndicator(
                controller: pageController,
                count: images.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.deepOrange,
                  dotColor: Colors.grey,
                  expansionFactor: 4,
                  dotWidth: 10,
                  dotHeight: 10,
                  spacing: 5.0,
                ),
              ),
              Spacer(),
              FloatingActionButton(
                onPressed: () {
                  if (isLast) {
                    CacheHelper.saveData(key: 'welcome', value: true)
                        .then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    });
                  } else {
                    pageController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn);
                  }
                },
                child: Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
