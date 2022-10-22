// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../backend/schedule/database.dart';
import '../../backend/schedule/lecturerDb.dart';
import '../../backend/schedule/lecturerSchDbmodel.dart';
import '../../constant/colorcon.dart';
import '../../drawer/customdrawer.dart';
import '../Frontend/refactor/popupmenu.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DBHelperLecturer _dbHelper = DBHelperLecturer();

  Future<List<LecturerTask>>? _task;
  List<LecturerTask>? _currenttask;
  @override
  void initState() {
    _dbHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadtask();
    });
    super.initState();
    getUserData();
  }

  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String title = '';
  String starttime = '';
  String desc = '';
  String endtime = '';

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      title = sp.getString("title") ?? "";
      // starttime = sp.getString("email") ?? '';
      desc = sp.getString("desc") ?? '';
      endtime = sp.getString("endtime") ?? "";
    });
  }

  void loadtask() {
    _task = _dbHelper.QuerySchedule();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
          child: Scaffold(
              backgroundColor: const Color(0xFF12171D),
              drawer: const CustomDrawer(),
              appBar: AppBar(
                title: const Text("Work Schedule",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
                leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios)),
                toolbarHeight: 72,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: const Color(0xFF12171D),
                centerTitle: true,
                // backgroundColor: Colors.deepPurple,
                actions: [const PopupMenu()],
              ),
              body: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 60, right: 50, bottom: 30),
                  child: TextField(
                      decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8.0),
                    border: InputBorder.none,
                    fillColor: const Color(0xFF202328),
                    filled: true,
                    hintText: "Search",
                    hintStyle: const TextStyle(color: kTextColor),
                    prefixIcon:
                        const Icon(Icons.search, color: kTextColor, size: 26.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(23.0),
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        color: contcolor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      padding: EdgeInsets.only(top: 50.0, left: 44, right: 24),
                      child: ListView(children: [
                        Text(
                          "Notification",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        FutureBuilder<List<LecturerTask>>(
                            future: _task,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                _currenttask = snapshot.data;
                                return Column(
                                    children:
                                        snapshot.data!.map<Widget>((alarm) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 30.0),
                                        height: 200,
                                        width: 6,
                                        decoration: BoxDecoration(
                                          color: Colors.primaries[Random()
                                              .nextInt(
                                                  Colors.primaries.length)],
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(30.0),
                                            bottomLeft: Radius.circular(30.0),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 30.0),
                                            padding: const EdgeInsets.fromLTRB(
                                                20.0, 20.0, 20.0, 10.0),
                                            height: 200.0,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                              color: kCardColor,
                                              // borderRadius: BorderRadius.only(
                                              //   topRight: Radius.circular(12.0),
                                              //   bottomRight: Radius.circular(12.0),
                                              // ),
                                            ),
                                            child: Stack(
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: [
                                                        Icon(Icons.person,
                                                            size: 20,
                                                            color:
                                                                Colors.white),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                          "${alarm.signaturer}",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5.0),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.receipt,
                                                          color: Colors.white,
                                                          size: 18,
                                                        ),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                          "${alarm.course}",
                                                          style: TextStyle(
                                                            color: kTextColor,
                                                            fontSize: 15.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 6.0),
                                                    Row(
                                                      children: <Widget>[
                                                        const Icon(
                                                          Icons.lock_clock,
                                                          color: Colors.white,
                                                          size: 17.0,
                                                        ),
                                                        const SizedBox(
                                                            width: 10.0),
                                                        Text(
                                                          " ${alarm.starttime}",
                                                          style:
                                                              const TextStyle(
                                                            color: kTextColor,
                                                            fontSize: 15.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 4.0),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 25.0),
                                                      child: Text(
                                                        " ${alarm.note}",
                                                        style: TextStyle(
                                                          color: kTextColor,
                                                          //  color: Color.fromARGB(255, 231, 214, 214)
                                                          //  fontSize: 15.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          _dbHelper
                                                              .deleteSchedule(
                                                                  alarm.id);
                                                          loadtask();
                                                        },
                                                        child: Icon(
                                                            Icons.delete,
                                                            color:
                                                                Colors.white)))
                                              ],
                                            )),
                                      ),
                                    ],
                                  );
                                }).followedBy([
                                  // if (_currenttask!.length < 5)
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 50, right: 50),
                                    child: DottedBorder(
                                        strokeWidth: 2,
                                        color: Color(0xFFEAECFF),
                                        borderType: BorderType.RRect,
                                        radius: const Radius.circular(24),
                                        dashPattern: [5, 4],
                                        child: Center(
                                          child: Container(
                                            // margin:EdgeInsets.only(left: 20,right:20),
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(24)),
                                            ),
                                            child: MaterialButton(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 32,
                                                        vertical: 16),
                                                onPressed: () {},
                                                child: Column(children: [
                                                  Image.asset(
                                                    "assets/images/add_alarm.png",
                                                    scale: 1.5,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  const Text('Add Schedule',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'avenir'))
                                                ])),
                                          ),
                                        )),
                                  ),
                                ]).toList());
                              } else {
                                return const Center(
                                  child: Text(
                                    'Loading..',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }
                            })
                     
                     
                      ])),
                ),
              ]))),
    );
  }
}


  //  body: ListView(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(
  //                   top: 20.0, left: 60, right: 50, bottom: 30),
  //               child: TextField(
  //                   decoration: InputDecoration(
  //                 contentPadding: EdgeInsets.all(8.0),
  //                 border: InputBorder.none,
  //                 fillColor: Color(0xFF202328),
  //                 filled: true,
  //                 hintText: "Search",
  //                 hintStyle: TextStyle(color: kTextColor),
  //                 prefixIcon: Icon(Icons.search, color: kTextColor, size: 26.0),
  //                 enabledBorder: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(30.0),
  //                 ),
  //                 focusedBorder: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(30.0),
  //                 ),
  //               )),
  //             ),
  //             Container(
                
  //               child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     const Padding(
  //                       padding: EdgeInsets.only(top: 13.0, left: 24),
  //                       child: Text(
  //                         "Notification",
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 18.0,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 20.0),
  //                     ListView.builder(
  //                         physics: ScrollPhysics(),
  //                         // scrollDirection:Axis.horizontal,
  //                         shrinkWrap: true,
  //                         itemCount: 8,
  //                         itemBuilder: (context, index) => Expanded(
  //                           child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   Container(
  //                                     margin: EdgeInsets.only(bottom: 30.0),
  //                                    height:120 ,
  //                                    width:6,
  //                                     decoration:   BoxDecoration(
  //                                       color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
  //                                       borderRadius: const BorderRadius.only(
  //                                         topLeft: Radius.circular(30.0),
  //                                         bottomLeft: Radius.circular(30.0),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   Container(
  //                                     margin: EdgeInsets.only(bottom: 30.0),
  //                                     padding: EdgeInsets.fromLTRB(
  //                                         20.0, 20.0, 20.0, 10.0),
  //                                     height: 200.0,
  //                                     width: 370.0,
  //                                     decoration: const BoxDecoration(
  //                                       color: kCardColor,
  //                                       borderRadius: BorderRadius.only(
  //                                         topRight: Radius.circular(12.0),
  //                                         bottomRight: Radius.circular(12.0),
  //                                       ),
  //                                     ),
  //                                     child: Stack(
  //                                       children: <Widget>[
  //                                         Column(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: <Widget>[
  //                                             Row(
  //                                               children: const [
  //                                                 Icon(Icons.person,
  //                                                     size: 20,
  //                                                     color: Colors.white),
  //                                                 SizedBox(width: 10.0),
  //                                                 Text(
  //                                                   "Dr. Abimbola",
  //                                                   style: TextStyle(
  //                                                     color: Colors.white,
  //                                                     fontSize: 18.0,
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             SizedBox(height: 5.0),
  //                                             Row(
  //                                               children: const [
  //                                                 Icon(
  //                                                   Icons.receipt,
  //                                                   color: Colors.white,
  //                                                   size: 18,
  //                                                 ),
  //                                                 SizedBox(width: 10.0),
  //                                                 Text(
  //                                                   "CSE 201",
  //                                                   style: TextStyle(
  //                                                     color: kTextColor,
  //                                                     fontSize: 15.0,
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             SizedBox(height: 6.0),
  //                                             Row(
  //                                               children: <Widget>[
  //                                                 const Icon(
  //                                                   Icons.lock_clock,
  //                                                   color: Colors.white,
  //                                                   size: 17.0,
  //                                                 ),
  //                                                 const SizedBox(width: 10.0),
  //                                                 Text(
  //                                                   "9:30-12_30am ${DateFormat.yMMMMEEEEd().format(DateTime.now())}",
  //                                                   style: TextStyle(
  //                                                     color: kTextColor,
  //                                                     fontSize: 15.0,
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             SizedBox(height: 4.0),
  //                                             const Padding(
  //                                               padding:
  //                                                   EdgeInsets.only(left: 25.0),
  //                                               child: Text(
  //                                                 " Hey, student i am fixing a lecture tomorrow \n by 8:00 to 10: 00am at the academic building \n LRM C13.Don't forget to submit your assignment",
  //                                                 style: TextStyle(
  //                                                   color: kTextColor,
  //                                                   //  color: Color.fromARGB(255, 231, 214, 214)
  //                                                   //  fontSize: 15.0,
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                         ))
  //                   ]),
  //             ),
  //           ],
  //         ),
        