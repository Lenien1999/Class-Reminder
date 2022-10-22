import 'package:classreminderapp/backend/timetablemg/addtimetable.dart';
import 'package:classreminderapp/ui/Frontend/courserepository/courserepo.dart';
import 'package:classreminderapp/ui/Frontend/managetimtable/timetable.dart';
import 'package:flutter/material.dart';
import '../ui/Frontend/Homepage.dart';
import '../ui/Frontend/courserepository/cousreReg/cousrereg.dart';
import '../ui/Schedule/lecturerschedule.dart';
import '../ui/Frontend/userprofile/profile.dart';
import '../ui/Schedule/schedulepage.dart';
import 'bottomuser.dart';
import 'customlistile.dart';
import 'header.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 500),
        width: _isCollapsed ? 300 : 70,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Color.fromRGBO(20, 20, 20, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDrawerHeader(isColapsed: _isCollapsed),
              const Divider(
                color: Colors.grey,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.home_outlined,
                title: 'Home',
                infoCount: 0, tap: () { 
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Homepage()),
                  );
                 },
              ),
                 CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.person,
                tap: () { 
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Myprofile()),
                  );
                 },
                title: 'Profile',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.calendar_today,
                title: 'TimeTable',
                infoCount: 0,
                tap: () { 
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Timetable()),
                  );
                 },
              ),

              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.calendar_today,
                title: 'Add TimeTable',
                infoCount: 0,
                tap: () { 
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddTimeTable()),
                  );
                 },
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.book_online,
                title: 'Course Registration',
                infoCount: 0,
                tap: () {  
                     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DataTableDemo()),
                  );
                },
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
                 CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.message_rounded,
                tap: () { 
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LecturerSch()),
                  );
                 },
                title: 'Create Schedule',
                infoCount: 8,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.message_rounded,
                tap: () { 
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SchedulePage()),
                  );
                 },
                title: 'Schedule',
                infoCount: 8,
              ),
               
              // CustomListTile(
              //   isCollapsed: _isCollapsed,
              //   icon: Icons.info_outline_rounded,
              //   tap: () {  },
              //   title: 'Annoucement',
              //   infoCount: 4,
              //   doHaveMoreOptions: Icons.arrow_forward_ios,
              // ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.book_rounded,
                tap: () { 
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CourseRepo()),
                  );
                 },
                title: 'Course Material',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              const Divider(color: Colors.grey),
              const Spacer(),
              CustomListTile(
                isCollapsed: _isCollapsed,
                tap: () { 
              
                 },
                icon: Icons.notifications,
                title: 'Notifications',
                infoCount: 2,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.settings,
                tap: () {  },
                title: 'Settings',
                infoCount: 0,
              ),
              const SizedBox(height: 10),
              BottomUserInfo(isCollapsed: _isCollapsed),
              Align(
                alignment: _isCollapsed
                    ? Alignment.bottomRight
                    : Alignment.bottomCenter,
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(
                    _isCollapsed
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      _isCollapsed = !_isCollapsed;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}