import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

  Future<bool> alertExiteApp(){
   Get.defaultDialog(
    title: "Alert",
     middleText: "Are you sure to exite app",
     actions: [
      
      ElevatedButton(onPressed: (){
                      exit(0);
      }, 
      child: const Text("confirm")
      ),

      ElevatedButton(onPressed: (){
               Get.back();
      }, 
      child: const Text("cancel")
      ),

     ]
  );

  return Future.value(true);
}