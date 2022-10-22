// ignore_for_file: prefer_const_constructors_in_immutables, prefer_final_fields, unused_field, non_constant_identifier_names, sized_box_for_whitespace, avoid_print, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Course {
  String Coursename;
  String coursecode;
  int courseunit;

  Course(
      {required this.coursecode,
      required this.Coursename,
      required this.courseunit});

  static List<Course> getUsers() {
    return <Course>[
      Course(
          coursecode: ("MTH 101"),
          Coursename: "MATHEMATICS METHOD 1",
          courseunit: 3),
      Course(
          coursecode: ("MTH 101"),
          Coursename: "MATHEMATICS METHOD 1",
          courseunit: 3),
      Course(
          coursecode: ("MTH 101"),
          Coursename: "MATHEMATICS METHOD 1",
          courseunit: 3),
      Course(
          coursecode: ("MTH 101"),
          Coursename: "MATHEMATICS METHOD 1",
          courseunit: 3),
      Course(
          coursecode: ("MTH 101"),
          Coursename: "MATHEMATICS METHOD 1",
          courseunit: 3),
      Course(
          coursecode: ("MTH 101"),
          Coursename: "MATHEMATICS METHOD 1",
          courseunit: 3),
      Course(
          coursecode: ("MTH 101"),
          Coursename: "MATHEMATICS METHOD 1",
          courseunit: 3),
      Course(
          coursecode: ("MTH 101"),
          Coursename: "MATHEMATICS METHOD 1",
          courseunit: 3),
      Course(
          coursecode: ("MTH 101"),
          Coursename: "MATHEMATICS METHOD 1",
          courseunit: 3),
      Course(
          coursecode: ("MTH 101"),
          Coursename: "MATHEMATICS METHOD 1",
          courseunit: 3)
    ];
  }
}

class CourseReg extends StatefulWidget {
  CourseReg() : super();

  @override
  CourseRegState createState() => CourseRegState();
}

class CourseRegState extends State<CourseReg> {
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  List<Course> Courses = [];

  late List<Course> selectedcourses;

  // late bool sort;
  int totalunit = 0;

  @override
  void initState() {
    // sort = false;

    selectedcourses = [];
    Courses = Course.getUsers();
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

  onSelectedRow(bool selected, Course user) async {
    setState(() {
      if (selected) {
        selectedcourses.add(user);
        totalunit += user.courseunit;
      } else {
        selectedcourses.remove(user);
        totalunit -= user.courseunit;
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

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DataTable(
              // sortAscending: sort,
              dataRowHeight: 60,
              sortColumnIndex: 0,
              columns: [
                DataColumn(
                  label: Text("Course Code",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                      )),
                  numeric: false,
                  tooltip: " Course code",
                  // onSort: (columnIndex, ascending) {
                  //   setState(() {
                  //     sort = !sort;
                  //   });
                  //   onSortColum(columnIndex, ascending);}
                ),
                DataColumn(
                  label: Text("Course Name",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                      )),
                  numeric: false,
                  tooltip: " Course Name",
                ),
                DataColumn(
                  label: Text("Units",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                      )),
                  numeric: false,
                  tooltip: "Course unit",
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
                        Text(user.coursecode),
                        onTap: () {},
                      ),
                      DataCell(
                        Text(user.Coursename),
                        onTap: () {},
                      ),
                      DataCell(
                        Text('${user.courseunit}'),
                        onTap: () {
                          print('Selected ${user.courseunit}');
                        },
                      ),
                    ]),
              ).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Row(
                children: [
                  Text("TOTAL UNITS:",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    width: 50,
                  ),
                  Text('$totalunit',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   
    return Container(
      color: Colors.redAccent,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 7,
            toolbarHeight: 72,
            title: Image.asset("images/logo.png"),
            iconTheme: const IconThemeData(color: Colors.redAccent),
            centerTitle: true,
            backgroundColor: Colors.white,
           
           
          ),
          body: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 13, left: 15),
                child: const Text(
                  'Course Registration',
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 23, left: 15, right: 80),
              //   height: 30,
              //   width: 10,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12), color: Colors.pink),
              //   child: TextButton(
              //     onPressed: () {},
              //     style: ButtonStyle(
              //       backgroundColor: MaterialStateProperty.resolveWith<Color>(
              //         (Set<MaterialState> states) {
              //           if (states.contains(MaterialState.pressed))
              //             return Theme.of(context)
              //                 .colorScheme
              //                 .primary
              //                 .withOpacity(0.5);
              //           return Colors.red; // Use the component's default.
              //         },
              //       ),
              //     ),
              //     child: Text(
              //       "Refresh",
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 13),
              //     ),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: (dataBody()),
              ),
              const SizedBox(
                height: 80,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      border: Border.all(color: Colors.red, width: 2)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Preview Selected Courses",
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "You Have Selected ${selectedcourses.length} Courses",
                          style: GoogleFonts.roboto(
                              fontSize: 18, color: Colors.green)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          DataTable(
                            dataRowHeight: 50,
                            columns: [
                              DataColumn(
                                label: Container(
                                  width: 40,
                                  child: Text("Course Code",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                numeric: false,
                                tooltip: "Course Code",
                                // onSort: (columnIndex, ascending) {
                                //   setState(() {
                                //     sort = !sort;
                                //   });
                                //   onSortColum(columnIndex, ascending);}
                              ),
                              DataColumn(
                                label: Text("Course Name",
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                    )),
                                numeric: false,
                                tooltip: "Course Name",
                              ),
                              DataColumn(
                                label: Text("Units",
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                    )),
                                numeric: false,
                                tooltip: "Course Units",
                              ),
                            ],
                            rows: selectedcourses
                                .map(
                                  (user) => DataRow(cells: [
                                    DataCell(
                                      Text(user.coursecode),
                                      onTap: () {},
                                    ),
                                    DataCell(
                                      Text(user.Coursename),
                                      onTap: () {},
                                    ),
                                    DataCell(
                                      Container(
                                          width: 20,
                                          child: Text('${user.courseunit}')),
                                      onTap: () {
                                        print('Selected ${user.courseunit}');
                                      },
                                    ),
                                  ]),
                                )
                                .toList(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("TOTAL UNITS::",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                              )),
                          Text('$totalunit',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                      Container(
                          height: 30,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.redAccent),
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Register Courses",
                                style: TextStyle(color: Colors.white),
                              ))),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
