import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/bindings/initialBinding.dart';
import 'package:water_jar/core/services/services.dart';
import 'package:water_jar/routes.dart';

void main() async {

   WidgetsFlutterBinding.ensureInitialized();
   await initialServices();
  
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "PlayfairDisplay",
        textTheme: const TextTheme(
                headline1:    TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white,),
                bodyText1:   TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.white,),
                      
        ),
        primarySwatch: Colors.blue,
      ),
    //  home:    const OnBoarding(), // route  بعملها بال  middleware عشان إستخدم ال 
           //Test(),
       initialBinding: InitialBinding(), // delete from memory the previous texts
       
       //routes: routes ,
       getPages: routes,

    );
  }
}


