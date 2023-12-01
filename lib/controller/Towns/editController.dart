

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Towns/viewController.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/townsModel.dart';

class EditTownController extends GetxController {
  
  SqlDb sqlDb = SqlDb();
  // SqlDb sqlDb = SqlDb(Get.find());
  List<TownsModel> towns = [];
 
  TownsModel? townsModel;
  
  String? id;

  StatusRequest statusRequest = StatusRequest.none;

 // GlobalKey<FormState> formState = GlobalKey<FormState>();
 final formState = GlobalKey<FormState>();

  TextEditingController name =TextEditingController();
 



  updateData(id) async {
    if(formState.currentState!.validate()){

      statusRequest = StatusRequest.loading;
      update();

      List<Map> existingrecords = await sqlDb.readData
                            ('''
                             SELECT * FROM towns WHERE id != "${id}" AND (name = "${name.text}")
                            ''');
          if(existingrecords.isNotEmpty) {
             statusRequest = StatusRequest.failure;
        Get.defaultDialog(title: "Warning", middleText: "name already exists");
          }else{

      
        // Fetch the existing values if needed
      List<Map> existingDistrictsData = await sqlDb.readData('''
        SELECT name FROM towns WHERE id = "${id.toString()}"
      ''');
      String existingName = existingDistrictsData[0]['name'];
      

      

     
      // Check if the name has changed
      bool nameChanged = name.text != existingName;
      


      if(nameChanged ){

      int response = await sqlDb.updateData('''
          UPDATE towns SET
            name = "${name.text}"
            
            WHERE id = "${id.toString()}"
        ''');
        

        print("##########################Controller ${name.text}");

         statusRequest = handlingData("// $response //");

         if (StatusRequest.success == statusRequest) {
         if(response > 0) 
         {
            print("Update Successful");
            ViewTownsController controller = Get.put(ViewTownsController());
             controller.readData();
             print("Update readData");
            Get.offAllNamed(AppRoute.townview);

             Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Data updated Successfully", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blue.shade400,
            );


         }
      }
      }
      else{
        
       print("The Same Data");
      ViewTownsController controller = Get.put(ViewTownsController());
      controller.readData();
      Get.offAllNamed(AppRoute.townview);
      
      Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Data are the Same", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green.shade400,
            );
      }

  update();

          }
          update();
      
    }
    
  }


  @override
  void onInit() {

    townsModel = Get.arguments["townsModel_"];


     name= TextEditingController();

     // get data from db view to texts in edit
    id = townsModel!.id.toString();
    name.text =  townsModel!.name.toString();

    super.onInit();
  }

  @override
  void dispose() {
   name.dispose();
    super.dispose();
  }


}