import 'package:classreminderapp/ui/Frontend/refactor/popupmenu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../drawer/customdrawer.dart';

class TbManageModel {
  String course;
  String classes;
  String time;

  TbManageModel(
      {required this.course, required this.classes, required this.time});

  static List<TbManageModel> getUsers() {
    return <TbManageModel>[
      TbManageModel(
          course: "CSE102", classes: "LRM C13", time: "8:00am-9:00am"),
      TbManageModel(
          course: "CSE102", classes: "LRM C13", time: "8:00am-9:00am"),
      TbManageModel(
          course: "CSE102", classes: "LRM C13", time: "8:00am-9:00am"),
      TbManageModel(
          course: "CSE102", classes: "LRM C13", time: "8:00am-9:00am"),
      TbManageModel(
          course: "CSE102", classes: "LRM C13", time: "8:00am-9:00am"),
      TbManageModel(course: "CSE102", classes: "LRM C13", time: "8:00am-9:00am")
    ];
  }
}

class TimetableManagement extends StatefulWidget {
  const TimetableManagement({Key? key}) : super(key: key);

  @override
  State<TimetableManagement> createState() => _TimetableManagementState();
}

class _TimetableManagementState extends State<TimetableManagement> {
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  List<TbManageModel> Courses = [];

  late List<TbManageModel> selectedcourses;

  // late bool sort;
  TextStyle textstyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
  );

  @override
  void initState() {
    // sort = false;

    selectedcourses = [];
    Courses = TbManageModel.getUsers();
    super.initState();
  }

  // onSortColum(int columnIndex, bool ascending) {
  //   if (columnIndex == 0) {
  //     if (ascending) {
  //       Courses.sort((
  //         a,
  //         b,
  //       ) =>
  //           a.coursecode.compareTo('${b.courseunit}'));
  //     } else {
  //       Courses.sort((
  //         a,
  //         b,
  //       ) =>
  //           a.coursecode.compareTo('${b.courseunit}'));
  //     }
  //   }
  // }

  onSelectedRow(bool selected, TbManageModel user) async {
    setState(() {
      if (selected) {
        selectedcourses.add(user);
        // totalunit += user.c;
      } else {
        selectedcourses.remove(user);
      }
    });
  }

  registerSelected() async {
    setState(() {
      // if (selectedcourses.isNotEmpty) {
      //   List<Course> temp = [];
      //   temp.addAll(selectedcourses);
      //   for (Course user in temp) {
      //     Courses.remove(user);
      //     selectedcourses.remove(user);
      //   }
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurple,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
            child: Scaffold(
                backgroundColor: Color(0xFF12171D),
                drawer: const CustomDrawer(),
                appBar: AppBar(
                  title: const Text("Manage TimeTable",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      )),
                  leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  toolbarHeight: 72,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.white),
                  backgroundColor: Color(0xFF12171D),
                  centerTitle: true,
                  // backgroundColor: Colors.deepPurple,
                  actions: [PopupMenu()],
                ),
                body: SingleChildScrollView(
                  child: DataTable(
                    // sortAscending: sort,
                    dataRowHeight: 60,
                    sortColumnIndex: 0,
                    columns: [
                      DataColumn(
                        label: Text("Course",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        numeric: false,
                        tooltip: " Course",
                        // onSort: (columnIndex, ascending) {
                        //   setState(() {
                        //     sort = !sort;
                        //   });
                        //   onSortColum(columnIndex, ascending);}
                      ),
                      DataColumn(
                        label: Text("Class",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        numeric: false,
                        tooltip: " Class",
                      ),
                      DataColumn(
                        label: Text("Time",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        numeric: false,
                        tooltip: "Time",
                      ),
                    ],
                    rows: Courses.map(
                      (user) => DataRow(
                          selected: selectedcourses.contains(user),
                          onSelectChanged: (b) {
                            onSelectedRow(b!, user);
                          },
                          cells: [
                            DataCell(
                              Text(
                                user.course,
                                style: textstyle,
                              ),
                              onTap: () {
                                selected:
                                selectedcourses.contains(user.course);
                              },
                            ),
                            DataCell(
                              Text(user.classes, style: textstyle),
                              onTap: () {},
                            ),
                            DataCell(
                              Text('${user.time}', style: textstyle),
                              onTap: () {},
                            ),
                          ]),
                    ).toList(),
                  ),
                ))));
  }
}
