import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/core/constant/routes.dart';

class CustomTextRegisterORLogin extends StatelessWidget {
  final String textOne;
  final String textTwo;
  final void Function()? onTap;

  const CustomTextRegisterORLogin({ super.key,
     required this.textOne,
     required this.textTwo,
     required this.onTap
      });

  @override
  Widget build(BuildContext context) {
    return                Container(margin:const EdgeInsets.only(top: 30.0,left: 80.0, right: 70.0),
                child:
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [
                Text(textOne),

                InkWell(onTap: onTap,
                child: Text(textTwo, 
                style: const TextStyle(color: Colors.blue, fontSize: 15.0,decoration: TextDecoration.underline,)))
                
               // TextButton(onPressed: (){Get.toNamed(AppRoute.adminlogin);}, child:const Text("Signin", style: TextStyle(color: Colors.blue, fontSize: 15.0,decoration: TextDecoration.underline,)) ,)
               ],) 
               ,);
  }
}