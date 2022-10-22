
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'assignment.dart';
import 'resource.dart';

class CourseRepo extends StatefulWidget {
  @override
  _CourseRepoState createState() => _CourseRepoState();
}

class _CourseRepoState extends State<CourseRepo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF12171D),
      // drawer: const CustomDrawer(),
      // appBar: AppBar(
      //   leading: GestureDetector(
      //       onTap: () {
      //         Navigator.pop(context);
      //       },
      //       child: Icon(Icons.arrow_back_ios)),
      //   toolbarHeight: 72,
      //   elevation: 0,
      //   iconTheme: IconThemeData(color: Colors.white),
      //   backgroundColor: Color(0xFF12171D),
      //   centerTitle: true,
      //   // backgroundColor: Colors.deepPurple,
      //   actions: [PopupMenu()],
      // ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xFF12171D),
              flexibleSpace: Image.asset(
                "assets/images/learning2.png",
                height: 200,
                width:120,
              ),
              // title: Text(
              //   "WhatsApp type sliver appbar",
              // ),
              //centerTitle: true,
              pinned: true,
              //  floating: true,
              toolbarHeight: 190,
              bottom: TabBar(
                  padding: const EdgeInsets.only(left: 16.0),
                  isScrollable: true,
                  indicatorWeight: 7.0,
                  unselectedLabelColor: Colors.white.withOpacity(0.3),
                  indicatorColor: Colors.red,
                  labelPadding: const EdgeInsets.only(
                    bottom: 10,
                    right: 16,
                  ),
                  controller: _tabController,
                  tabs: [
                    Text("Material",
                        style: GoogleFonts.lato(
                            color: Colors.white, fontSize: 20)),
                    Text("Assignment",
                        style: GoogleFonts.lato(
                            color: Colors.white, fontSize: 20)),
                  ]),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            Resources(),
            Assignment(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
