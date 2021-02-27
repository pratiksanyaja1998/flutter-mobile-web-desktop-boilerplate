import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_web_desktop_boilerplate/model/TaskTodoModel.dart';
import 'package:mobile_web_desktop_boilerplate/services/FireStoreDatabase.dart';
import 'package:intl/intl.dart';

class TaskHistoryScreenUI extends StatefulWidget {
  @override
  _TaskHistoryScreenUIState createState() => _TaskHistoryScreenUIState();
}

class _TaskHistoryScreenUIState extends State<TaskHistoryScreenUI> {

  final _formKey = GlobalKey<FormState>();
  List<TaskTodoModel> _listTask = [];
  TextEditingController _taskTitleEditingController = new TextEditingController();
  TextEditingController _taskDescEditingController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body:
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
         child: _getTasks()
        )

      )));
  }



  Widget _itemTaskList(List<QueryDocumentSnapshot> list,int index) {
    return Container(

      margin: EdgeInsets.all(8.0),
      child: Material(
        color: Colors.white,elevation: 5.0,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Expanded(
                flex:1,
                child: Container(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(

                          children: [
                            new Icon(Icons.event_note),
                            SizedBox(width: 4.0,),
                            Flexible(
                              child: new Text(list[index]['taskTitle'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                fontSize: 20.0,fontWeight: FontWeight.w600
                              ),),
                            ),
                        ]),
                        SizedBox(height: 10.0,),
                        new Text(DateFormat('yyyy-MM-dd, kk:mm a').format(list[index]['created_at'].toDate())),
                        SizedBox(height: 10.0,),
                        Row(
                          children: [
                            Flexible(
                              child: new Text(list[index]['taskDesc'],overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: TextStyle(
                                  fontSize: 16.0,fontWeight: FontWeight.w400
                              ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ),

              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  GestureDetector(
                      onTap:(){

                      showDialog(
                          context: context,
                          builder: (context) {
                            return showDialogFun(list[index].id,list[index]['taskTitle'], list[index]['taskDesc']);
                      });
                      },
                      child: new Icon(Icons.edit,size: 24.0,color: Colors.green,),
                      ),
                  GestureDetector(
                      onTap:(){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return showDeleteAlertDialog((list[index].id));
                            });

                      },
                      child: new Icon(Icons.delete,size: 24.0,color: Colors.red,)),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTasks() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tasks').orderBy('created_at', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return
              snapshot.data.docs.length > 0 ?

              ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (BuildContext context, int index) => _itemTaskList(snapshot.data.docs,index),
              itemCount: snapshot.data.docs.length,
            ): Center(child: new Text("Task is empty!"));
          } else {
            return Center(child: CircularProgressIndicator());
          }

        });
  }

  Widget showDialogFun(String id,String title,String desc){
    _taskTitleEditingController.text=title;
    _taskDescEditingController.text=desc;

    return AlertDialog(
      title: Text(
        'Edit Tasks',
        textAlign: TextAlign.center,
      ),
      titleTextStyle: TextStyle(
        fontSize: 16.0,
        color: Theme.of(context).textTheme.title.color,
        fontWeight: FontWeight.w800,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'.toUpperCase()),
        ),
        FlatButton(
          onPressed: () {


            editFireBaseTaskData(id);

          },
          child: Text('Submit'.toUpperCase()),
        ),
      ],
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _taskTitleEditingController,
                decoration: new InputDecoration(
                  fillColor: Colors.white,
                  labelText: "Enter Title",
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

            ],
          ),
        ),
      ),
    );
  }

  void editFireBaseTaskData(String id) {
    if (_formKey.currentState.validate()) {

      TaskTodoModel taskTodoModel = new TaskTodoModel();
      taskTodoModel.taskTitle = _taskTitleEditingController.text;
      taskTodoModel.taskDesc = _taskDescEditingController.text;
      taskTodoModel.dateTime = DateTime.now();

      print("AA "+taskTodoModel.toMap().toString());
      FireStoreDatabase.updateTask(id,taskTodoModel.toMap()).then((value){

        _taskTitleEditingController.text="";
        _taskDescEditingController.text="";
        Fluttertoast.showToast(
            msg: "Update Successfully !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.of(context).pop();
      },onError: (e){
        print(e);
        Navigator.of(context).pop();
      });
    }



  }

  Widget showDeleteAlertDialog(String id)  {
    return  AlertDialog(
      title: Text('Delete Task'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Are you sure want to delete this record?.'),
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
          child: Text('Delete'),
          onPressed: () {
            FireStoreDatabase.deleteTask(id);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

 /* String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time = '';
    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }
    return time;
  }*/
}
