import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobile_web_desktop_boilerplate/ui/DashboardScreenUI.dart';


class LoginScreenUI extends StatefulWidget {
  @override
  _LoginScreenUIState createState() => _LoginScreenUIState();

}

class _LoginScreenUIState extends State<LoginScreenUI> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(" W "+MediaQuery.of(context).size.width.toString());
    return SafeArea(
      child: Scaffold(body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,


        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment. center,
            children: [
              new FlutterLogo(
                  size: 100.0),
              SizedBox(
                height: 40.0,
              ),
              widgetFormContainer(),
            ],
          ),
        ),



      )),
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
              decoration: new InputDecoration(
                labelText: "Enter Email or User Name",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(
                  ),
                ),
                //fillColor: Colors.green
              ),
              keyboardType: TextInputType.emailAddress,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Email or Username';
                }
                return null;
              },
            ),
            SizedBox(height:16.0),
            TextFormField(

              decoration: new InputDecoration(
                labelText: "Enter Password",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(
                  ),
                ),
                //fillColor: Colors.green
              ),
              keyboardType: TextInputType.visiblePassword,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
              validator: (value1) {
                if (value1.isEmpty) {
                  return 'Please enter Password';
                }

                return null;
              },
            ),
            SizedBox(height:16.0),
            new RaisedButton(
              onPressed: signInFun,
              textColor: Colors.white,
              color: Colors.blue,
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                "Sign In",
              ),
            ),
          ],
        ),
      ),
    );
 }

  void signInFun() async {

    if (_formKey.currentState.validate()) {
      Get.to(DashboardScreenUI());
      Fluttertoast.showToast(
          msg: "Welcome to Dashboard",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );


    }




  }
}
