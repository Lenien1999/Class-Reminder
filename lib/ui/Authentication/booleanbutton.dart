import 'package:flutter/material.dart';
class SwitchScreen extends StatefulWidget {  
  @override  
  SwitchClass createState() => new SwitchClass();  
}  
  
class SwitchClass extends State {  
  bool isSwitched = false;  
  var textValue = 'Switch Button If Lecturer';  
  
  void toggleSwitch(bool value) {  
  
    if(isSwitched == false)  
    {  
      setState(() {  
        isSwitched = true;  
        
      });  
       
    }  
    else  
    {  
      setState(() {  
        isSwitched = false;  
      
      });  
     
    }  
  }  
  @override  
  Widget build(BuildContext context) {  
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:15.0),
      child: Row(  
          mainAxisAlignment: MainAxisAlignment.end,  
          children:[ 
            Text('$textValue', style: TextStyle(fontSize: 20,color: Colors.white),),
            
            Transform.scale(  
              scale: 1,  
              child: Switch(  
                onChanged: toggleSwitch,  
                value: isSwitched,  
                activeColor: Colors.blue,  
                activeTrackColor: Colors.green, 
                inactiveThumbColor: Colors.redAccent,  
                inactiveTrackColor: Colors.orange,  
              )  
            ),  
              
          ]),
    );  
  }  
}  