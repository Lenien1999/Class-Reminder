import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../refactor/popupmenu.dart';

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
          coursecode: ("CSE 407"),
          Coursename: "SOFTWARE PROFESSIONAL PRACT. ",
          courseunit: 2),
      Course(
          coursecode: ("CSE 402"),
          Coursename: "SOFTWARE ECONOMICS ",
          courseunit: 3),
      Course(
          coursecode: ("CSE 404"),
          Coursename: "HUMAN COMP. INTERACTION",
          courseunit: 3),
      Course(
          coursecode: ("CSC 303"),
          Coursename: "SOFTWARE TESTING ",
          courseunit: 2),
    
    ];
  }
}

class DataTableDemo extends StatefulWidget {
  DataTableDemo() : super();

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
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
      
    });
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.only(top: 30),
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
                        color:Colors.white
                      )),
                  numeric: false,
                  tooltip: " Course code",
                  
                ),
                DataColumn(
                  label: Text("Course Name",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                         color:Colors.white
                      )),
                  numeric: false,
                  tooltip: " Course Name",
                  
                ),
                DataColumn(
                  label: Text("Units",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                         color:Colors.white
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
                        Text(user.coursecode,style: TextStyle( 
                          fontSize: 18,
                          color:Colors.white),),
                        onTap: () {},
                      ),
                      DataCell(
                        Text(user.Coursename,style: TextStyle( 
                          fontSize: 18,
                          color:Colors.white),),
                        onTap: () {},
                      ),
                      DataCell(
                        Text('${user.courseunit}',style: TextStyle( 
                          fontSize: 18,
                          color:Colors.white),),
                        onTap: () {
                          print('Selected ${user.courseunit}',);
                        },
                      ),
                    ]),
              ).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Row(
                children: [
                  Text("TOTAL UNITS:",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                         color:Colors.white
                      )),
                  SizedBox(
                    width: 50,
                  ),
                  Text('$totalunit',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )),
                  SizedBox(
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
    // final List<Details> detail_list = Details.getdetails();
    return  Container(
      color: Colors.deepPurple,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF12171D),
          
          appBar: AppBar(
            title: Text("Course Registration",
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
          body: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 13, left: 15),
                child: Text(
                  'Course Registration',
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
 
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: (dataBody()),
              ),
              SizedBox(
                height: 80,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      border: Border.all(color: Colors.red, width: 2)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text("Preview Selected Courses",
                          style:
                              GoogleFonts.roboto(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold)),
                      SizedBox(
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
                          SizedBox(
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
                          SizedBox(
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
                              child: Text(
                                "Register Courses",
                                style: TextStyle(color: Colors.white),
                              ))),
                      SizedBox(
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
