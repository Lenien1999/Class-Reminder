 
import 'package:classreminderapp/backend/auth/controller/dbuser.dart';
import 'package:classreminderapp/ui/Refactor/roundedbutton.dart';
import 'package:flutter/material.dart';
 
import 'package:shared_preferences/shared_preferences.dart';
 
import '../../../constant/colorcon.dart';
 

class Myprofile extends StatefulWidget {
  const Myprofile({Key? key}) : super(key: key);

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
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
  
  late DBHelperUser dbHelper;
  @override
  void initState() {
    super.initState();
    getUserData();

    dbHelper = DBHelperUser();
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
            appBar: AppBar(
              backgroundColor: backcoolor,
              elevation: 0,
              automaticallyImplyLeading: true,
              actions: const [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.settings),
                )
              ],
            ),
            body: ListView(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(153),
                    child: Image.asset(
                      "assets/images/profile.jpg",
                      height: 100,
                    )),
                const SizedBox(
                  height: 20,
                ),
                  Column(
                    children: [
                      Text(name,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                        Text( fname +" " + lname,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    )),
                    ],
                  ),
                
                const SizedBox(
                  height: 20,
                ),
                // const Padding(
                //   padding: EdgeInsets.all(18.0),
                //   child: Divider(
                //     color:Colors.white,
                //     thickness:2
                //   ),
                // ),
                 
                 Padding(
                    padding:
                        const EdgeInsets.only(left: 18.0, right: 18, top: 30),
                    child: Container(
                      // margin: EdgeInsets.all(34),

                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Student Details",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            profiledetails(
                              details: fname,
                              hint: 'Fisrt Name',
                            ),
                            profiledetails(
                              details: lname,
                              hint: 'Last Name',
                            ),
                            profiledetails(
                                details: password, hint: 'Email'),
                            profiledetails(
                                details: name, hint: 'Matric Number'),
                            SizedBox(
                              height: 20,
                            ),
                            RoundedButton(text: "Update", press: () {}),
                            // const Spacer(),
                          ]),
                    ),
                  ),
                
              ],
            ),

            //     body: Center(
            //   child: FutureBuilder<UserModel>(
            //     future: user,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return Text(snapshot.data!.firstName.toString());
            //       } else if (snapshot.hasError) {
            //         return Text('${snapshot.error}');
            //       }

            //       // By default, show a loading spinner.
            //       return const CircularProgressIndicator();
            //     },
            //   ),
            // ),
          ),
        ));
  }

  profiledetails({required String hint, required String details}) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(33)),
      height: 90,
      child: Card(
        elevation: 30,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              hint,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 9, 17, 138)),
            ),
            Text(
              details,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 128, 12, 31),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}



