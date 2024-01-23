

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Company/viewCompany.dart';
import 'package:water_jar/controller/Towns/viewController.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/companyModels.dart';
import 'package:water_jar/data/model/townsModel.dart';

class AddCompanyController extends GetxController {
  
  SqlDb sqlDb = SqlDb();
  
  List<CompanyModels> company = [];


  StatusRequest statusRequest = StatusRequest.none;

 // GlobalKey<FormState> formState = GlobalKey<FormState>();
 final formState = GlobalKey<FormState>();

  TextEditingController name =TextEditingController();
 


  insertData() async {
    
    if(formState.currentState!.validate()) 
    {
      statusRequest = StatusRequest.loading;
      update();
 try {
     // Check if the name already exists
      List<Map> existingRecords = await sqlDb.readData('''
                               
                        SELECT * FROM company WHERE name = "${name.text}"                                  
                     
                                  ''');
        if(existingRecords.isNotEmpty)
           {
            statusRequest = StatusRequest.failure;
        Get.defaultDialog(title: "Warning", middleText: "name already exists");
           }else{

           int response =await sqlDb.insertData('''
                                           INSERT INTO company ('name')                   
                                           VALUES("${name.text}")        
                                       ''');
            print("=*//*--================ $response");                           

                 statusRequest = handlingData("response");
                 if(StatusRequest.success == statusRequest)
                 {
                  if(response > 0)
                  {
                     ViewCompaniesController controller = Get.put(ViewCompaniesController());
                    controller.readData();
                    // Get.offAllNamed(AppRoute.companyview);
                    Get.back();

            Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Data added Successfully", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green.shade400,
            );    
                 
       print("SUCCESS TO Add Company");
                   
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
    super.onInit();
  }

  @override
  void dispose() {
   name.dispose();
    super.dispose();
  }


}