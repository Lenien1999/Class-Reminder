// ignore_for_file: file_names

import 'package:classreminderapp/backend/schedule/database.dart';
import 'package:classreminderapp/ui/Frontend/refactor/mybutton.dart';
import 'package:classreminderapp/ui/Frontend/refactor/popupmenu.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../backend/schedule/schedulemodel.dart';
import '../../constant/colorcon.dart';
import '../../drawer/customdrawer.dart';
import '../Schedule/addschedule.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextStyle get subheadingstyle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ));
  }

  TextStyle get headingstyle {
    return GoogleFonts.lato(
        textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      //color: Get.isDarkMode ? Colors.green : Colors.black,
    ));
  }

  // final TaskController _taskcontroller = Get.put(TaskController());


  final DBHelper _dbHelper = DBHelper();

  Future<List<Task>>? _task;


  void loadtask() {
    _task = _dbHelper.Query();
    if (mounted) setState(() {});
  }


  
 
  @override
  void initState() {
    _dbHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadtask();
    });
    super.initState();
    
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: backcoolor,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: backcoolor,
        drawer: const CustomDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 72,
          elevation: 0,
          title: Image.asset(
            "assets/images/logo.png",
            height: 30,
          ),
          iconTheme: const IconThemeData(color: Colors.redAccent),
          // centerTitle: true,
          backgroundColor: backcoolor,
          actions: [const PopupMenu()],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5, top: 30, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${DateFormat.yMMMMd().format(DateTime.now())}",
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                //color: Get.isDarkMode ? Colors.green : Colors.black,
                              ))),
                          Text(
                            "Today",
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              //color: Get.isDarkMode ? Colors.green : Colors.black,
                            )),
                          ),
                        ]),
                  ),
                  Mybutton(
                      label: "+ Add Task",
                      ontap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AddSchedule()),
                        );
                      }),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 10),
              child: DatePicker(DateTime.now(),
                  height: 100,
                  width: 60,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.deepPurple,
                  selectedTextColor: Colors.white,
                  monthTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  dateTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  dayTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ), onDateChange: (date) {
                setState(() {
                });
              }),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: FutureBuilder<List<Task>>(
                  future: _task,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                          children: snapshot.data!.map<Widget>((alarm) {
                        var gradientColor = _getBGClr(alarm.color!);
                        return AnimationConfiguration.staggeredGrid(

                            //  columnCount: columnCount,

                            position: 0,
                            columnCount: 0,
                            child: SlideAnimation(
                                child: FadeInAnimation(
                                    child: Row(children: [
                              GestureDetector(
                                onTap: () {},
                                child:
                                    ScheduleTile(context, gradientColor, alarm),
                              )
                            ]))));
                      }).followedBy([
                        Container(
                          padding: EdgeInsets.all(23),
                          child: DottedBorder(
                              strokeWidth: 2,
                              color: Colors.deepPurpleAccent,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(24),
                              dashPattern: [5, 4],
                              child: Center(
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24)),
                                  ),
                                  child: MaterialButton(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32, vertical: 16),
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
                  }),
            )
          
          
          
          
          
          
          ],
        ),
      )),
    );
  }

  Widget ScheduleTile(BuildContext context, gradientColor, Task alarm) {
      getFormatedDate(_date) {
      var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
      var inputDate = inputFormat.parse(_date.toString());
      var outputFormat = DateFormat('HH:mm');
    return outputFormat.format(inputDate);
    }
              
    // final DateFormat dateFormat = DateFormat("hh:mm a");
var format = DateFormat.yMd('en');
var dateString = format.format(DateTime.now());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: gradientColor,
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " ${alarm.title}",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${dateString}- ${alarm.endtime}",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  alarm.note ?? " ",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 15,
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      _dbHelper.delete(alarm.id);
                      loadtask();
                    },
                    child: Icon(Icons.delete, color: Colors.white)),
                Text(
                  "complete",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.pink;
      default:
        return Colors.deepPurple;
    }
  }
}
