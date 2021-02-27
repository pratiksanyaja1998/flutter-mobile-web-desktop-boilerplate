import 'package:flutter/material.dart';

class Resolution{

  static bool isDesktopWeb(BuildContext context){
    if(MediaQuery.of(context).size.width>650){
      return true;
    }else{
      return false;
    }
  }



}

