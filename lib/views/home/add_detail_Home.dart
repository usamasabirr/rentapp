import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rentapp/controllers/add_detail_controller.dart';
import 'package:rentapp/views/chat/chat_detail.dart';
import 'package:rentapp/views/home/maps.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AddDetailHome extends StatefulWidget {
  String path;
  AddDetailHome({Key? key, required this.path}) : super(key: key);

  @override
  State<AddDetailHome> createState() => _AddDetailHomeState();
}

class _AddDetailHomeState extends State<AddDetailHome> {
  AddDetailController addDetailController = Get.put(AddDetailController());
  late ScrollController _controller;
  _moveUp(var mediaWidth) {
    _controller.animateTo(_controller.offset - mediaWidth,
        curve: Curves.linear, duration: Duration(milliseconds: 200));
  }

  _moveDown(var mediaWidth) {
    _controller.animateTo(_controller.offset + mediaWidth,
        curve: Curves.linear, duration: Duration(milliseconds: 200));
  }

  DateTime selectedDate = DateTime.now();
  String startDate = '';

  Future<void> _selectDate(BuildContext context, int dateType) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        if (dateType == 1) {
          addDetailController.changeStartDate(selectedDate);
        } else {
          addDetailController.changeEndDate(selectedDate);
        }
        print(addDetailController.startDate);
        // startDate = selectedDate.toString();
        // print('start date is $startDate');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        //main stack to make the top back button visible
        child: Stack(children: [
          Container(
            height: mediaHeight,
            width: mediaWidth,
            //main Column
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //top images list
                  Container(
                    height: mediaHeight * 0.3,
                    child: Stack(children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _controller,
                        itemCount: 3,
                        itemExtent: mediaWidth,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onPanUpdate: (details) {
                              if (details.delta.direction > 0) {
                                print('swipe left');
                                _moveUp(mediaWidth);
                              }

                              // Swiping in left direction.
                              if (details.delta.direction < 0) {
                                print('swipe right');
                                _moveDown(mediaWidth);
                              }
                            },
                            child: Container(
                              child: Image.asset(
                                widget.path,
                                fit: BoxFit.fill,
                                width: mediaWidth,
                              ),
                            ),
                          );
                        }),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: Container(
                          height: 20,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromARGB(255, 3, 90, 6),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '1/',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '3',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ]),
                        ),
                      ),
                    ]),
                  ),
                  //Price
                  SizedBox(
                    height: mediaHeight * 0.02,
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Rs 4,000/day',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  //Name
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'Buldozer',
                      style: TextStyle(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Text('Faisal Town, Lahore'),
                        Icon(Icons.location_on),
                        Expanded(
                          child: SizedBox(),
                        ),
                        Text('14-May-2022'),
                      ],
                    ),
                  ),
                  //Description

                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                    () => addDetailController.readMore.value == false
                        ? Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "Did you know the word ‘essay’ is derived from a Latin word ‘exagium’, which roughly translates to presenting one’s case? So essays are a short piece of writing representing one’s side of the argument or one’s experiences, stories, etc. Essays are very personalized. So let us learn about types of essays, format, and tips for essay-writing.",
                              maxLines: 4,
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "Did you know the word ‘essay’ is derived from a Latin word ‘exagium’, which roughly translates to presenting one’s case? So essays are a short piece of writing representing one’s side of the argument or one’s experiences, stories, etc. Essays are very personalized. So let us learn about types of essays, format, and tips for essay-writing.",
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      addDetailController.changeReadMoreValue();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Obx(
                            () => addDetailController.readMore.value == false
                                ? Text(
                                    'READ MORE',
                                  )
                                : Text('READ LESS')),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Ad Posted at',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(MapsSample());
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      height: mediaHeight * 0.2,
                      width: mediaWidth,
                      child: Stack(
                        children: [
                          Image(
                            image: AssetImage('assets/images/add_posted.png'),
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                              bottom: 20,
                              child: Center(
                                child: Container(
                                  color: Colors.white,
                                  child: Text(
                                    'Tap to View',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: mediaHeight * 0.05,
            width: mediaWidth,
            foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 1],
              colors: [
                Color.fromRGBO(0, 0, 0, 0.6),
                Color.fromRGBO(255, 255, 255, 0.2),
              ],
            )),
            child: Row(
              children: [],
            ),
          ),
          //Back button
          Positioned(
              top: 10,
              left: 10,
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios, color: Colors.white))),

          //bottom chat button
          Positioned(
            bottom: mediaHeight * 0.0,
            child: GestureDetector(
              onTap: () {
                Get.to(ChatDetail());
              },
              child: Container(
                width: mediaWidth,
                height: mediaHeight * 0.08,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey)),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Chat
                      Container(
                        height: mediaHeight * 0.06,
                        width: mediaWidth / 2 - 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffF4B755)),
                        margin: EdgeInsets.only(
                            top: mediaHeight * 0.01,
                            bottom: mediaHeight * 0.01),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: mediaWidth * 0.02,
                              ),
                              Text(
                                'Chat',
                                style: TextStyle(color: Colors.white),
                              )
                            ]),
                      ),
                      //book a wheel
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(BottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onClosing: () {},
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: ((context, setState) {
                                    return Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                  'Enter Details',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                            //Text('Amount/day'),
                                            TextField(
                                              decoration: InputDecoration(
                                                label: Text('Amount/day'),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Start Date',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _selectDate(context, 1);
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 30),
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                height: mediaHeight * 0.06,
                                                width: mediaWidth / 3 + 20,
                                                decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(children: [
                                                  Obx(
                                                    () => Text(DateFormat
                                                            .yMMMd()
                                                        .format(
                                                            addDetailController
                                                                .startDate
                                                                .value)),
                                                  ),
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: Color(0xffF4B755),
                                                  ),
                                                ]),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'End Date',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _selectDate(context, 2);
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 30),
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                height: mediaHeight * 0.06,
                                                width: mediaWidth / 3 + 20,
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Row(children: [
                                                  Obx(
                                                    () => Text(DateFormat
                                                            .yMMMd()
                                                        .format(
                                                            addDetailController
                                                                .endDate
                                                                .value)),
                                                  ),
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: Color(0xffF4B755),
                                                  ),
                                                ]),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Center(
                                              child: Container(
                                                height: mediaHeight * 0.06,
                                                width: mediaWidth / 2 - 20,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Color(0xffF4B755)),
                                                margin: EdgeInsets.only(
                                                    top: mediaHeight * 0.01,
                                                    bottom: mediaHeight * 0.01),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.send,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            mediaWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Submit Request',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              }));
                          // Get.defaultDialog(
                          //     title: 'Confirmation',
                          //     content:
                          //         Text('Are you sure you want to book the weel?'),
                          //     onConfirm: () {
                          //       Get.back();
                          //     },
                          //     onCancel: () {});
                        },
                        child: Container(
                          height: mediaHeight * 0.06,
                          width: mediaWidth / 2 - 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffF4B755)),
                          margin: EdgeInsets.only(
                              top: mediaHeight * 0.01,
                              bottom: mediaHeight * 0.01),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.car_rental,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: mediaWidth * 0.02,
                                ),
                                Text(
                                  'Book a Wheel',
                                  style: TextStyle(color: Colors.white),
                                )
                              ]),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
