import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_web_desktop_boilerplate/ui/LoginScreenUI.dart';
import 'package:mobile_web_desktop_boilerplate/ui/TaskAddScreenUI.dart';
import 'package:mobile_web_desktop_boilerplate/ui/TaskHistoryScreenUI.dart';

class DashboardScreenUI extends StatefulWidget {
  @override
  _DashboardScreenUIState createState() => _DashboardScreenUIState();
}

class _DashboardScreenUIState extends State<DashboardScreenUI> {

   int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(


      child: WillPopScope(
        onWillPop: (){
          return showDialog(
              context: context,
              builder: (context) {
                return showAlertDialog("Exit App", "exit from this app?",true);
              });

        },

        child: Scaffold(
          appBar: AppBar(
            title: Text('Task Management', style: TextStyle(
                fontSize: 22.0, color: Colors.white
            ),),
            leading: new Container(),centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: (){


                      return showDialog(
                          context: context,
                          builder: (context) {
                            return showAlertDialog("Logout", "logout account?",false);
                          });
                    },
                    child: Icon(Icons.logout,size: 24.0,color: Colors.white,)),
              )
            ],
          ),
          body: new Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,

            child: _children[_currentIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,// this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.add_box),
                label: 'Create Task',
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.event_note_sharp),
                label: 'Your Tasks',
              ),

            ],
          ),
        ),
      ),
    );
  }
   void onTabTapped(int index) {

     setState(() {
       _currentIndex = index;
     });

   }
  List<Widget> _children = [
    TaskAddScreenUI(),
    TaskHistoryScreenUI()
  ];



   Widget showAlertDialog(String title,String message,bool isExitToApp)  {
     return  AlertDialog(
       title: Text('$title'),
       content: SingleChildScrollView(
         child: ListBody(
           children: <Widget>[
             isExitToApp ?  Text('Are you sure want to $message')
                 : Text('Are you sure want to $message'),
           ],
         ),
       ),
       actions: <Widget>[
         TextButton(
           child: Text('Cancel'),
           onPressed: () {
             Navigator.of(context).pop();
           },
         ),
         TextButton(
           child: Text('Ok'),
           onPressed: () {
             if(isExitToApp){
               Navigator.of(context).pop();
               SystemNavigator.pop();

             }else{
               Navigator.of(context).pop();
               Get.offAll(LoginScreenUI());
             }

           },
         ),
       ],
     );
   }

}
