import 'dart:math';

import 'package:classreminderapp/backend/timetablemg/timetabledb.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../backend/timetablemg/timetablemodel.dart';
import '../../../constant/colorcon.dart';

class Timetable extends StatefulWidget {
  const Timetable({Key? key}) : super(key: key);

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
   DBHelperttable _dbHelper = DBHelperttable();

  Future<List<TimeTable>>? _task;
  List<TimeTable>? _currenttask;
  @override
  void initState() {
    _dbHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadtask();
    });
    super.initState();
     
  }
 void loadtask() {
    _task = _dbHelper.Query ();
    if (mounted) setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: backcoolor,
   child: Scaffold(
      
      appBar: AppBar(
        backgroundColor: backcoolor,
        elevation:50,
        centerTitle: true,
        // ignore: prefer_const_constructors
        title: Text(
          "TimeTable",
        
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: backcoolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
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
 
  FutureBuilder<List<TimeTable>>(
                            future: _task,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                  getFormatedDate(date) {
      var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
      var inputDate = inputFormat.parse(date.toString());
      var outputFormat = DateFormat('HH:mm');
    return outputFormat.format(inputDate);
    }
                                _currenttask = snapshot.data;
                                return Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Column(
                                      children:
                                          snapshot.data!.map<Widget>((alarm) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 30.0),
                                          height: 140,
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
                                              height: 150.0,
                                              width: double.infinity,
                                              decoration: const BoxDecoration(
                                                color: kCardColor,
                                               
                                              ),
                                              child: Stack(
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Row(
                                                        children: [
                                                          
                                                          const SizedBox(width: 10.0),
                                                            Text(
                                                            alarm.title.toString(),
                                                            style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 22.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 10.0),
                                                        Row(
                                                        children: <Widget>[
                                                          const SizedBox(
                                                              width: 10.0),
                                                          const Icon(
                                                            Icons.av_timer,
                                                            color: Colors.white,
                                                            size: 17.0,
                                                          ),
                                                          const SizedBox(
                                                              width: 10.0),
                                                          Text(
                                                            "${getFormatedDate(alarm.starttime)  }- ${alarm.endtime}",
                                                            style:
                                                                const TextStyle(
                                                              color: kTextColor,
                                                              fontSize: 15.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    const SizedBox(height: 10.0),
                                                      Row(
                                                        children: [
                                                         
                                                          const SizedBox(width: 10.0),
                                                            Text(
                                                            alarm.coursecode.toString(),
                                                            style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 18.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 6.0),
                                                    
                                                      
                                                    ],
                                                  ),
                                                  Positioned(
                                                      bottom: 0,
                                                      right: 10,
                                                       
                                                          child:   Text(
                                                              alarm.day.toString(),
                                                            style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15.0,
                                                            ),
                                                               ))
                                                ],
                                              )),
                                        ),
                                      ],
                                    );
                                  }).toList()),
                                );
                              } else {
                                return const Center(
                                  child: Text(
                                    'Loading..',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }
                            })
                     
  
    ]))));
  }

  // ignore: non_constant_identifier_names

}
Widget CardWidget({
   required String time,
    required String lecturetime,
    required String course,
    required String coursetitle,
}){
  return  Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Text(
           time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const LinGene(
              lines: [2.0, 3.0, 4.0, 1.0],
            )
          ]),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
            ),
            child: Container(
                margin: const EdgeInsets.only(left: 4.0),
                padding: const EdgeInsets.only(left: 16, top: 8),
                color: const Color(0xfffcf9f5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 22.0,
                      child: Row(
                        children: [
                          Text(lecturetime,style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color:Colors.black,
                            fontSize: 17
                          )
                          )),
                          const VerticalDivider(),
                          Text(course,style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color:Colors.black,
                            fontSize: 17
                          )
                          ))
                        ],
                      ),
                    ),
                    Text(coursetitle,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                )),
          ),
        )
      ],
    );
  }

class LinGene extends StatefulWidget {
  final List lines;
  const LinGene({Key? key, required this.lines}) : super(key: key);

  @override
  State<LinGene> createState() => _LinGeneState();
}

class _LinGeneState extends State<LinGene> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
          4,
          (index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 14.0),
                height: widget.lines[index],
                width: 20,
                color: Colors.black,
              )),
    );
  }
}

class DayWidget extends StatefulWidget {
  final index;
  const DayWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<DayWidget> createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {
  bool _salectDay = true;
  var list = ["Mon", "Tue", "Wed", "Thurs", "Fri"];
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _salectDay = !_salectDay;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: _salectDay
            ? null
            : const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Column(children: [
          Text(list[widget.index],
              style: TextStyle(
                fontSize: 22,
                fontWeight: _salectDay ? FontWeight.normal : FontWeight.bold,
                color: _salectDay ? Colors.pinkAccent : Colors.white,
              )),
        
          // Container(
          //     width: 5.0,
          //     height: 5.0,
          //     decoration: const BoxDecoration(
          //         shape: BoxShape.circle, color: Color(0xff8e7daf)))
        ]),
      ),
    );
  }
}
