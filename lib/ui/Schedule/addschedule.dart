import 'package:classreminderapp/backend/schedule/database.dart';
import 'package:classreminderapp/backend/schedule/schedulemodel.dart';
import 'package:classreminderapp/ui/Frontend/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../../../constant/colorcon.dart';
import '../../main.dart';
import '../Frontend/refactor/mybutton.dart';
import '../Frontend/refactor/popupmenu.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  State<AddSchedule> createState() => _AddTaskBarState();
}

class _AddTaskBarState extends State<AddSchedule> {
  final titlecontroller = TextEditingController();

  // final TaskController taskController = Get.put(TaskController());

  String _endtime = "9:30 pm";
  int _selectedremind = 5;
  List<int> reminderlist = [5, 10, 15, 20];
  String _selectedrepeat = "none";
  List<String> repeatlist = ["None", "daily", "weekly", "monthly"];
  int _selectedcolor = 0;
  DateTime _selecteddate = DateTime.now();
  final notecontroller = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  late String _starttimestring;
  // final TaskController taskController = Get.put(TaskController());
  bool isloading = false;
  DateTime? _starttime;
  String _startmytime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  DBHelper _dbHelper = DBHelper();
  String _mytarttime = '9:30 Am';
  Future<List<Task>>? _task;
  List<Task>? _currenttask;
  @override
  void initState() {
    _dbHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadtask();
    });
    super.initState();
  }

  void loadtask() {
    _task = _dbHelper.Query();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: Scaffold(
          backgroundColor: backcoolor,
          appBar: AppBar(
            title: const Text("Add Schedule",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                )),
            leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Homepage()),
                  );
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
          body: Container(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
            child: SingleChildScrollView(
                child: Column(
              children: [
                // Text(
                //             "Add Timetable",
                //             style: GoogleFonts.lato(
                //   textStyle: const TextStyle(
                // fontSize: 30,
                // color: Colors.white,
                // fontWeight: FontWeight.bold,
                // //color: Get.isDarkMode ? Colors.green : Colors.black,
                //                       )),
                //           ),
                Myinputfield(
                    controller: titlecontroller,
                    title: "Title",
                    hint: "Enter the Course"),
                Myinputfield(
                    controller: notecontroller,
                    title: "Description",
                    hint: "Enter the Course Title"),
                Myinputfield(
                    title: 'Date',
                    hint: DateFormat.yMd().format(_selectedDate),
                    widget: IconButton(
                        onPressed: () {
                          _getdatefromuser();
                        },
                        icon: const Icon(Icons.calendar_today_outlined))),
                Row(
                  children: [
                    Expanded(
                        child: Myinputfield(
                            title: 'Start Time',
                            hint: _startmytime,
                            widget: IconButton(
                                onPressed: () {
                                  _gettimefromuser(isstartTime: true);
                                },
                                icon: const Icon(Icons.access_time_rounded,
                                    color: Colors.white)))),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: Myinputfield(
                            title: 'End Time',
                            hint: _endtime,
                            widget: IconButton(
                                onPressed: () {
                                  _gettimefromuser(isstartTime: false);
                                },
                                icon: const Icon(Icons.access_time_rounded,
                                    color: Colors.grey))))
                  ],
                ),
                Myinputfield(
                    widget: DropdownButton(
                        icon: const Icon(Icons.keyboard_arrow_down,color: Colors.white,  ),
                        iconSize: 32,
                        
                        elevation: 4,
                        onChanged: (String? newvalue) {
                          setState(() {
                            _selectedremind = int.parse(newvalue!);
                          });
                        },
                        underline: Container(height: 0),
                        items: reminderlist
                            .map<DropdownMenuItem<String>>((int e) =>
                                DropdownMenuItem(
                                    value: e.toString(),
                                    child: Text(e.toString())))
                            .toList()),
                    title: "Remind",
                    hint: "$_selectedremind minutes early"),
              
              
                Myinputfield(
                    widget: DropdownButton(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 32,
                        elevation: 4,
                        onChanged: (String? newvalue) {
                          setState(() {
                            _selectedrepeat = newvalue!;
                          });
                        },
                        underline: Container(height: 0),
                        items: repeatlist
                            .map<DropdownMenuItem<String>>(
                                (String e) => DropdownMenuItem(
                                    value: e,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(e),
                                    )))
                            .toList()),
                    title: "Repeat",
                    hint: "$_selectedrepeat   "),
                
                const SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    colorPalete(),
                    Mybutton(
                        label: "Create task",
                        ontap: () {
                          validatedate();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Homepage()),
                          );
                        })
                  ],
                )
              ],
            )),
          )),
    );
  }

  _addTaskToDB() async {
    DBHelper _dbhelper = DBHelper();
    DateTime scheduleAlarmDateTime;

    if (_starttime!.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = _starttime!;
    } else {
      scheduleAlarmDateTime = _starttime!.add(Duration(days: 1));
    }

    var taskinfo = Task(
      note: notecontroller.text,
      title: titlecontroller.text,
      date: DateFormat.yMd().format(_selecteddate),
      starttime: scheduleAlarmDateTime,
      endtime: _endtime,
      remind: _selectedremind,
      repeat: _selectedrepeat,
      color: _selectedcolor,
    );
    _dbhelper.inserttask(taskinfo);
    if (scheduleAlarmDateTime != null) {
      scheduleAlarm(scheduleAlarmDateTime, taskinfo);
    }
  }

  validatedate() {
    if (notecontroller.text.isNotEmpty && titlecontroller.text.isNotEmpty) {
      //add to database
      _addTaskToDB();
      Navigator.pop(context);
      loadtask();
    } else if (titlecontroller.text.isEmpty) {
      return Fluttertoast.showToast(
          msg: "Title cannot be Empty",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } else if (notecontroller.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Description cannot be Empty",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }

  Myinputfield(
      {required String title,
      required String hint,
      TextEditingController? controller,
      Widget? widget}) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: 52,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white,
                width: 0.6,
              )),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                   
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  readOnly: widget == null ? false : true,
                  autofocus: false,
                  controller: controller,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                    color: Colors.white,
                  )),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: hint,
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0)),
                    hintStyle: GoogleFonts.lato(
                        textStyle: const TextStyle(
                      color: Colors.grey,
                     
                    )),
                  ),
                ),
              ),
              widget == null
                  ? Container()
                  : Container(
                      child: widget,
                    )
            ],
          ),
        )
      ]),
    );
  
  }

  _getdatefromuser() async {
    DateTime? pickedate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));
    if (pickedate != null) {
      setState(() {
        _selecteddate = pickedate;
      });
    } else {
      printError();
    }
  }

  _showtimepicker() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input);
  }

  _gettimefromuser({required bool isstartTime}) async {
    var _pickedtime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay.now(),
    );

    String formatedTime = _pickedtime!.format(context);

    if (_pickedtime == null) {
      print("Time canceled");
    } else if (isstartTime == true ) {
      if ( _pickedtime != null){

  final now = DateTime.now();
      var selectedDateTime = DateTime(
          now.year, now.month, now.day, _pickedtime.hour, _pickedtime.minute);
      setState(() {
        _starttime = selectedDateTime;
      });
      }

    
    } else if (isstartTime == false) {
      setState(() {
        _endtime = formatedTime;
      });
    }
  }

  colorPalete() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Color",
        style: GoogleFonts.lato(
            textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
      ),
      const SizedBox(
        height: 8,
      ),
      Wrap(
        children: List.generate(
          3,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedcolor = index;
              });
            },
            child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? Colors.blue
                        : index == 1
                            ? Colors.green
                            : Colors.pink,
                    child: _selectedcolor == index
                        ? const Icon(Icons.done, color: Colors.white, size: 16)
                        : null)),
          ),
        ),
      ),
    ]);
  }

  void scheduleAlarm(
    DateTime scheduledNotificationDateTime,
    Task taskInfo,
  ) async {
    // int newTime = minutes;
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: 'logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('logo'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      taskInfo.title,
      taskInfo.note,

      // convertTime(hour, minutes),
      tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }
}
