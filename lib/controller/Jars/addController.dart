

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Jars/viewCompany.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/jarModels.dart';

class AddJarController extends GetxController {
  
  SqlDb sqlDb = SqlDb();
  
  List<JarModels> jar = [];


  StatusRequest statusRequest = StatusRequest.none;

 // GlobalKey<FormState> formState = GlobalKey<FormState>();
 final formState = GlobalKey<FormState>();

  TextEditingController name =TextEditingController();
  TextEditingController price=TextEditingController();

 


  insertData() async {
    
    if(formState.currentState!.validate()) 
    {
      statusRequest = StatusRequest.loading;
      update();
 try {
     // Check if the name already exists
      List<Map> existingRecords = await sqlDb.readData('''
                               
                        SELECT * FROM jars WHERE name = "${name.text}"                                  
                     
                                  ''');
        if(existingRecords.isNotEmpty)
           {
            statusRequest = StatusRequest.failure;
        Get.defaultDialog(title: "Warning", middleText: "name already exists");
           }else{

           int response =await sqlDb.insertData('''
                                           INSERT INTO jars ('name', 'price')                   
                                           VALUES("${name.text}", "${price.text}")        
                                       ''');
            print("=*//*--================ $response");                           

                 statusRequest = handlingData("response");
                 if(StatusRequest.success == statusRequest)
                 {
                  if(response > 0)
                  {
                     ViewJarsController controller = Get.put(ViewJarsController());
                    controller.readData();
                    // Get.offAllNamed(AppRoute.companyview);
                    Get.back();

            Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Data added Successfully", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green.shade400,
            );    
                 
       print("SUCCESS TO Add Jar");
                   
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
 }
    
  }

  @override
  void onInit() {
     name= TextEditingController();
     price= TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
   name.dispose();
   price.dispose();

    super.dispose();
  }


}