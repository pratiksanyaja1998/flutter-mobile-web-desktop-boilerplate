import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_web_desktop_boilerplate/model/TaskTodoModel.dart';
import 'package:mobile_web_desktop_boilerplate/services/FireStoreDatabase.dart';

class TaskAddScreenUI extends StatefulWidget {


  @override
  _TaskAddScreenUIState createState() => _TaskAddScreenUIState();
}


class _TaskAddScreenUIState extends State<TaskAddScreenUI> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _taskTitleEditingController = new TextEditingController();
  TextEditingController _taskDescEditingController = new TextEditingController();
  bool isLoaderShow=false;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body : Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            child: Stack

              (
              children: [
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Container(
                      margin: EdgeInsets.only(left: 14.0),
                      child: Row(
                        children: [

                          new Image.asset('assets/icons/clipboard.png',height: 32.0,width: 32.0,color: Colors.blue,),

                          SizedBox(width: 12.0,),

                          new Text("Create Task",style: TextStyle(fontSize: 28.0,fontWeight: FontWeight.bold,color:
                          Colors.blue),),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 40.0,
                    ),

                    widgetFormContainer(),
                  ],
                ),

                isLoaderShow? Center(child: new CircularProgressIndicator()) : new Container()
              ],

            ),

          )

      ),
    );
  }


  Widget widgetFormContainer() {
    return new Container(
      margin: EdgeInsets.only(left: 16.0,right: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [

            TextFormField(
              controller: _taskTitleEditingController,
              decoration: new InputDecoration(
                fillColor: Colors.white,
                labelText: "Enter "
                    "Title",
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(
                  ),
                ),
                //fillColor: Colors.green
              ),
              keyboardType: TextInputType.text,

              style: new TextStyle(
                fontFamily: "Poppins",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Title';
                }
                return null;
              },
            ),
            SizedBox(height:16.0),
            TextFormField(
                controller: _taskDescEditingController,

                decoration: new InputDecoration(
                  labelText: "Enter "
                      "Description or Message",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(
                  ),
                ),
                //fillColor: Colors.green
              ),

              keyboardType: TextInputType.text,
              maxLines: 6,
              textAlignVertical: TextAlignVertical.top,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
              validator: (value1) {
                if (value1.isEmpty) {
                  return 'Please Enter Description';

                }

                return null;
              },
            ),
            SizedBox(height:16.0),
            new RaisedButton(
              onPressed: addDataToFireDB,
              textColor: Colors.white,
              color: Colors.blue,
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "Submit",
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addDataToFireDB() async {

     if (_formKey.currentState.validate()) {

       setState(() {
         isLoaderShow=true;
       });

       TaskTodoModel taskTodoModel = new TaskTodoModel();
       taskTodoModel.taskTitle = _taskTitleEditingController.text;
       taskTodoModel.taskDesc = _taskDescEditingController.text;
       taskTodoModel.dateTime = DateTime.now();

       print("AA "+taskTodoModel.toMap().toString());
       FireStoreDatabase.addTask(taskTodoModel.toMap()).then((value){

         _taskTitleEditingController.text="";
         _taskDescEditingController.text="";
         Fluttertoast.showToast(
             msg: "Task Submitted Successfully !",
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.BOTTOM,
             timeInSecForIosWeb: 1,
             backgroundColor: Colors.green,
             textColor: Colors.white,
             fontSize: 16.0
         );

         setState(() {
           isLoaderShow=false;
         });
       },onError: (e){
         setState(() {
           isLoaderShow=false;
         });
         print(e);
       });

    }


  }


}
