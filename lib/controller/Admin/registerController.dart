import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/core/services/services.dart';
import 'package:water_jar/data/model/adminModel.dart';

class RegisterController extends GetxController{

   SqlDb sqlDb = SqlDb();
 List<AdminModels> admins = [];

  Myservices myservices = Get.find();



 StatusRequest statusRequest = StatusRequest.none; 

  GlobalKey<FormState> formState = GlobalKey<FormState>();

   TextEditingController name = TextEditingController();
   TextEditingController phone = TextEditingController();
   TextEditingController password = TextEditingController();

   int? id;
   int? status;




     bool isShowPassword = true;

  showPassword(){
   isShowPassword = isShowPassword == true ? false : true;
   update();
  }



     registerData() async {
    
    if(formState.currentState!.validate()) 
    {
      statusRequest = StatusRequest.loading;
      update();
 try {
     // Check if the name already exists
      List<Map> existingRecords = await sqlDb.readData('''
                               
                        SELECT * FROM admin WHERE name = "${name.text}" OR phone = "${phone.text}"                                 
                     
                                  ''');
        if(existingRecords.isNotEmpty)
           {
            statusRequest = StatusRequest.failure;
        Get.defaultDialog(title: "Warning", middleText: "name OR phone already exists");
           }else{

           int response =await sqlDb.insertData('''
                                           INSERT INTO admin ('name','phone','password','status')                   
                                           VALUES("${name.text}", "${phone.text}", "${password.text}",1)        
                                       ''');
            print("=*//*--================ $response");                           

                 statusRequest = handlingData("response");
                 if(StatusRequest.success == statusRequest)
                 {
                  if(response > 0)
                  {

           
                     Get.offNamed(AppRoute.home);
                    

            Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Register Success", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green.shade400,
            );    
                 
       print("SUCCESS Registration");
                   
                  }else {
            print("Status.FAILED");
            statusRequest = StatusRequest.failure;
            Get.defaultDialog(title: "Warning", middleText: "An error occurred while adding data");
          }
          }                      
           } 
                               
    }   catch (e) {
      print("Error: $e");
      update();
      print("Here the eroor");
      statusRequest = StatusRequest.failure;
      Get.defaultDialog(title: "Error", middleText: "An error occurred while adding data");
    }
    update();
 }
    
  }



  @override
  void onInit() {

    name=TextEditingController();
    phone=TextEditingController();
    password=TextEditingController();

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