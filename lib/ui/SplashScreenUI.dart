import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_web_desktop_boilerplate/ui/LoginScreenUI.dart';

class SplashScreenUI extends StatefulWidget {
  @override
  _SplashScreenUIState createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
        Get.to(LoginScreenUI());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height : MediaQuery.of(context).size.height,
        width : MediaQuery.of(context).size.width,
        color: Colors.white,
        child: new Container(
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

                new Text("Mob-Web-Desktop",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color:
                Colors.blue),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
