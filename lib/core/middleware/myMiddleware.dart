import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMidlleware extends GetMiddleware{

  @override
  int? get priority => 1;
  
  Myservices myservices = Get.find();


  @override
  RouteSettings? redirect(String? route) {


        if(myservices.sharedPreferences.getString("step") == "4"){
        return const RouteSettings(name: AppRoute.ordersHomePage);
    }

        if(myservices.sharedPreferences.getString("step") == "3"){
        return const RouteSettings(name: AppRoute.driverLogin);
    }




    // step 2 الأولويه لل 
     if(myservices.sharedPreferences.getString("step") == "2"){
        return const RouteSettings(name: AppRoute.home);
    }
  
    if(myservices.sharedPreferences.getString("step") == "1"){
        return const RouteSettings(name: AppRoute.adminlogin);
    }

    

  return null;
  }
}

