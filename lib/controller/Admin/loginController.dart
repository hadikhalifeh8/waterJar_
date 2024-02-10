import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/core/services/services.dart';
import 'package:water_jar/data/model/adminModel.dart';

class LoginController extends GetxController{

   SqlDb sqlDb = SqlDb();
   List<AdminModels> admins = [];
   Myservices myservices = Get.find();


 StatusRequest statusRequest = StatusRequest.none; 

  GlobalKey<FormState> formState = GlobalKey<FormState>();

   TextEditingController name= TextEditingController();
   TextEditingController phone= TextEditingController();
   TextEditingController password= TextEditingController();

   String? id;
   int? status;



        bool isShowPassword = true;

  showPassword(){
   isShowPassword = isShowPassword == true ? false : true;
   update();
  }




    Future loginData() async {
        if(formState.currentState!.validate()) 
    {
       update();
    statusRequest = StatusRequest.loading;

List<Map> response = await sqlDb.readData('''
  SELECT id, name FROM admin WHERE phone = '${phone.text}' AND password = '${password.text}' 
''');

      print("***************##############************* Controler $response ");

                                
            statusRequest = handlingData(response); 

             if(StatusRequest.success == statusRequest)
     {       
       

            if( response.length > 0)
            {
                    // if not approve the account     
      //  if(response[0]['status'] == "1")
      //  {
        myservices.sharedPreferences.setString("id", response[0]['id'].toString());
       myservices.sharedPreferences.setString("name", response[0]['name'].toString());
       myservices.sharedPreferences.setString("phone", response[0]['phone'].toString());
       myservices.sharedPreferences.setString("password", response[0]['password'].toString());

       myservices.sharedPreferences.setString("step", "2");

       Get.offNamed(AppRoute.home);
      //  }  else{
      //        Get.toNamed(AppRoute.verifyCodeSignup, arguments: { "email": email.text});
      //  }

                 // Save login state to SQFlite


                
                 //Get.offAllNamed(AppRoute.home);
                    

            Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Login Success", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green.shade400,
            );  

            update();
            print("yes Succefully Login");
            return response;
            
            
     
        }

         else {
         Get.defaultDialog(title: "Warning ", middleText: "Phone or Password  not correct");
        statusRequest = StatusRequest.failure; // insert / update/ delete : لا يوجد تحديث / getdata : لا يوجد بيانات
      }
    } else {
      Get.offAllNamed(AppRoute.adminlogin);
      print("Login failed");
    }
  update();
  
    }
  }


  logout()
  {
    
       // String userid = myservices.sharedPreferences.getString("id").toString();

//     FirebaseMessaging.instance.unsubscribeFromTopic("users"); // لكل المستخدمين
//     FirebaseMessaging.instance.unsubscribeFromTopic("users${userid}"); // خاص Topic إلو  user  كل // firebase topic for specific user
// print("{Logoout User id is : $userid}");

   myservices.sharedPreferences.clear(); // null 
   Get.offAllNamed(AppRoute.adminlogin);
  }





  @override
  void onInit() {
    

    name = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    password.dispose();

    super.dispose();
  }
}

