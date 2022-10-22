
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopupMenu extends StatefulWidget {
  const PopupMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
    Future<SharedPreferences> _pref = SharedPreferences.getInstance();
   String name='';
    String email='';
    String fname='';
    String lname='';
    String password='';
     
    
  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
        name = sp.getString("user_id") ?? "";
        fname = sp.getString("email") ?? '';
       lname = sp.getString("lname") ?? '';
        password = sp.getString("password") ?? "";
        email = sp.getString("fname") ?? "";
    });
  }
    
  @override
  void initState() {
    super.initState();
    getUserData();

    
  }

  @override
  Widget build(BuildContext context) {
    
    return FocusedMenuHolder(
      menuWidth: MediaQuery.of(context).size.width * 0.5,
      menuOffset: -10,
      menuItems: [
        FocusedMenuItem(
            title: Text('My Profile'),
            trailingIcon: Icon(
              Icons.person,
              size: 12,
            ),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              //      null;
              // }));
            }),
        FocusedMenuItem(
            title: Text('logout'),
            trailingIcon: Icon(
              Icons.logout,
              size: 12,
            ),
            onPressed: () {})
      ],
      openWithTap: true,
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image.asset(
                'assets/images/profile.jpg',
                width: 40.0,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
