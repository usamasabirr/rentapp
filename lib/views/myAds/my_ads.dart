import 'package:flutter/material.dart';

class MyAds extends StatefulWidget {
  const MyAds({Key? key}) : super(key: key);

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  var _height1 = 2.0;
  var _width1 = 200.0;
  var _height2 = 0.0;
  var _width2 = 0.0;
  int index = 0;

  void changeLength1(double width) {
    setState(() {
      _height1 = 3;
      _width1 = width / 2;
      _height2 = 0.0;
      _width2 = 0.0;
    });
  }

  void changeLength2(double width) {
    setState(() {
      _height1 = 0;
      _width1 = 0;
      _height2 = 3;
      _width2 = width / 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        height: mediaHeight,
        width: mediaWidth,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: mediaHeight * 0.06,
            width: mediaWidth,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      changeLength1(mediaWidth);
                      index++;
                      print('index is $index');
                    },
                    child: Column(
                      children: [
                        Container(
                          width: mediaWidth / 2 - 5,
                          height: mediaHeight * 0.05,
                          child: Center(
                              child: Text(
                            'ADS',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn,
                          height: _height1,
                          width: _width1,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      changeLength2(mediaWidth);
                    },
                    child: Column(
                      children: [
                        Container(
                          width: mediaWidth / 2 - 5,
                          height: mediaHeight * 0.05,
                          child: Center(
                              child: Text('FAVOURITES',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn,
                          height: _height2,
                          width: _width2,
                          color: Colors.black,
                        )
                      ],
                    ),
                  )
                ]),
          ),
          //list view
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    height: mediaHeight * 0.14,
                    width: mediaWidth,
                    child: Row(
                      children: [
                        Container(
                          height: mediaHeight * 0.14,
                          width: mediaWidth * 0.35,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/image1.jpeg',
                                ),
                              ),
                              borderRadius: BorderRadius.circular(30)),
                          // child: Image(
                          //   image: AssetImage(
                          //     'assets/images/image1.jpeg',
                          //   ),
                          //   fit: BoxFit.fill,
                          //   height: mediaHeight,
                          //   width: mediaWidth * 0.3,
                          // ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(''),
                              Row(children: [
                                Text('Baldozer'),
                                Expanded(child: SizedBox()),
                                Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ]),
                              SizedBox(
                                height: mediaHeight * 0.3 * 0.02,
                              ),
                              Text(
                                'Rs 4000',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: mediaHeight * 0.3 * 0.01,
                              ),
                              Row(children: [
                                Text(
                                  'Faisal Town, Lahore',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  '18 May',
                                  style: TextStyle(fontSize: 12),
                                )
                              ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                })),
          )
        ]),
      ),
    );
  }
}