import 'package:classreminderapp/ui/Frontend/Homepage.dart';
import 'package:classreminderapp/ui/Schedule/notificationhelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/colorcon.dart';

import '../../backend/schedule/database.dart';
import '../../backend/schedule/lecturerDb.dart';
import '../../backend/schedule/lecturerSchDbmodel.dart';
import '../Frontend/refactor/mybutton.dart';
import '../Frontend/refactor/popupmenu.dart';

class LecturerSch extends StatefulWidget {
  const LecturerSch({Key? key}) : super(key: key);

  @override
  State<LecturerSch> createState() => _AddTaskBarState();
}

class _AddTaskBarState extends State<LecturerSch> {
  final titlecontroller = TextEditingController();

  // final TaskController taskController = Get.put(TaskController());
  final notecontroller = TextEditingController();
   final signaturecontroller = TextEditingController();
  DateTime _selectedtime = DateTime.now();
  String _mytarttime = '9:30 Am';
  DateTime? _starttime;
  String _endtime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  List<int> remindedList = [5, 10, 15, 20];
  int selectedremind = 5;
  String _selectedrepeat = "none";
  List<String> repeatlist = ["None", "daily", "weekly", "monthly"];
  int _selectedcolor = 0;
  DBHelperLecturer _dbHelper = DBHelperLecturer();
  Future<List<LecturerTask>>? _task;
  List<LecturerTask>? _currenttask;

  String _startmydate = DateFormat("hh:mm a").format(DateTime.now()).toString();



 Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  @override
  void initState() {
    _dbHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadtask();
    });
    super.initState();
  }

  void loadtask() {
    _task = _dbHelper.QuerySchedule();
    if (mounted) setState(() {});
  }

  NotificationHelper helper = NotificationHelper();
  Future setSP(LecturerTask task) async {
    final SharedPreferences sp = await _pref;

    sp.setString("title", task.course ?? "");
    sp.setString("desc", task.note ?? "");
    // sp.setDouble("starttime", task.starttime!??" ");
    sp.setString("endtime", task.endtime ?? "");
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: Scaffold(
          backgroundColor: backcoolor,
          appBar: AppBar(
            title: const Text("Create Schedule",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
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
            toolbarHeight: 82,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: backcoolor,
            centerTitle: true, 
            // backgroundColor: Colors.deepPurple,
            actions: [const PopupMenu()],
          ),
          body: Container(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Myinputfield(
                    controller: titlecontroller,
                    title: "Course",
                    hint: "Enter the Course"),
                Myinputfield(
                    controller: notecontroller,
                    title: "Description",
                    hint: "Enter the Description"),
                Myinputfield(
                    title: 'Date',
                    hint: DateFormat.yMd().format(_selectedtime),
                    widget: IconButton(
                        onPressed: () {
                          _getdatefromuser();
                        },
                        icon: const Icon(Icons.calendar_today_outlined))),
                Row(
                  children: [
                    Expanded(
                        child: Myinputfield(
                            title: 'Start Date',
                            hint: _mytarttime,
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
                            title: 'End Date',
                            hint: _endtime,
                            widget: IconButton(
                                onPressed: () {
                                  _gettimefromuser(isstartTime: false);
                                },
                                icon: const Icon(Icons.access_time_rounded,
                                    color: Colors.grey))))
                  ],
                ),
                const SizedBox(
                  height: 38,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Myinputfield(
                        controller: signaturecontroller,
                        title: "Lecturer Signature",
                        hint: "Enter Signature"),
                    const SizedBox(
                      height: 10,
                    ),
                    colorPalete(),
                    const SizedBox(
                      height: 28,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Mybutton(
                          label: "Create Task",
                          ontap: () {
                            validate();
                          }),
                    )
                  ],
                )
              ],
            )),
          )),
    );
  }

  Row colorPalete() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: GoogleFonts.lato(
              textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white)),
        ),
        Wrap(
            children: List<Widget>.generate(
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
                              ? Colors.purple
                              : index == 1
                                  ? Colors.pink
                                  : Colors.yellow,
                          child: _selectedcolor == index
                              ? const Icon(Icons.done, color: Colors.white)
                              : null,
                        ),
                      ),
                    )))
      ],
    );
  }

  _getdatefromuser() async {
    DateTime? _pickedate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));
    if (_pickedate != null) {
      setState(() {
        _selectedtime = _pickedate;
      });
    } else {
      // print Error();
    }
  }

  // ignore: non_constant_identifier_names
  Myinputfield(
      {required String title,
      required String hint,
      TextEditingController? controller,
      Widget? widget}) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 17,
            )),
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: 52,
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //     border: Border.all(
          //       color: Colors.grey,
          //       width: 1.0,
          //     )),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: widget == null ? false : true,
                  autofocus: false,
                  controller: controller,
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                    color: Colors.white,
                  )),
                  decoration: InputDecoration(
                    hintText: hint,
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0)),
                    hintStyle: GoogleFonts.lato(
                        textStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
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

  _gettimefromuser({required bool isstartTime}) async {
    var _pickedtime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay.now(),
    );

    String formatedTime = _pickedtime!.format(context);

    if (_pickedtime == null) {
      print("Time canceled");
    } else if ((isstartTime == true) && (_pickedtime != null)) {
      final now = DateTime.now();
      var selectedDateTime = DateTime(
          now.year, now.month, now.day, _pickedtime.hour, _pickedtime.minute);
      setState(() {
        _starttime=selectedDateTime;
      });
    } else if (isstartTime == false) {
      setState(() {
        _endtime = formatedTime;
      });
    }
  }

  _addTaskToDB() async {
    DBHelperLecturer _dbhelper = DBHelperLecturer();
    DateTime? scheduleAlarmDateTime;
    if (_starttime!.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = _starttime;
    } else {
      scheduleAlarmDateTime = _starttime!.add(Duration(days: 1));
    }

    var taskinfo = LecturerTask(
      note: notecontroller.text,
      course: titlecontroller.text,
      date: DateFormat.yMd().format(_selectedtime),
      starttime: scheduleAlarmDateTime,
      endtime: _endtime,
      color: _selectedcolor,
      signaturer:signaturecontroller.text,
    );
    _dbhelper.insertschedule(taskinfo);
    if (scheduleAlarmDateTime != null) {
      helper.scheduleAlarm(
          scheduleAlarmDateTime, titlecontroller.text, notecontroller.text);
    }
  }

  validate() {
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
}
