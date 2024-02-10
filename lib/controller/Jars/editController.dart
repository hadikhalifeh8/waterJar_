

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Jars/viewCompany.dart';

import 'package:water_jar/core/class/statusRequest.dart';

import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/jarModels.dart';






class EditJarController extends GetxController {
  
  SqlDb sqlDb = SqlDb();
  
  List<JarModels> jar = [];

JarModels? jarModels;



  StatusRequest statusRequest = StatusRequest.none;

 // GlobalKey<FormState> formState = GlobalKey<FormState>();
 final formState = GlobalKey<FormState>();

  TextEditingController name =TextEditingController();
  TextEditingController price =TextEditingController();


   String? id;


      updateData(id) async {
  if (formState.currentState!.validate()) {
    statusRequest = StatusRequest.loading;
    update();

    
    // Check if the phone number or name already exists
    List<Map> existingRecords = await sqlDb.readData('''
      SELECT * FROM jars WHERE id != "${id}" AND (name = "${name.text}" )
    ''');

    if (existingRecords.isNotEmpty) {
      statusRequest = StatusRequest.failure;
      Get.defaultDialog(title: "Warning", middleText: "name already exists");
    } else {
     
      // Fetch the existing values if needed
      List<Map> existingDriverData = await sqlDb.readData('''
        SELECT name FROM jars WHERE id = "${id.toString()}"
      ''');
      String existingName = existingDriverData[0]['name'];



     
      // Check if the name or phone has changed
      bool nameChanged = name.text != existingName;
      bool priceChanged = price.text != existingName;




     
      // If either name or phone has changed, perform the update
      if (nameChanged  || priceChanged) {
        int response = await sqlDb.updateData('''
          UPDATE jars SET
            name = "${name.text}",
            price = "${price.text}"

          WHERE id = "${id.toString()}"
        ''');

        statusRequest = handlingData("// $response //");

        if (StatusRequest.success == statusRequest) {
          if (response > 0) {
            print("Update Successful");
            ViewJarsController controller = Get.put(ViewJarsController());
            controller.readData();
            // Get.offAllNamed(AppRoute.companyview);
            Get.back();

                  Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Data Updated Successfully", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green.shade400,
            );

          } else {
            print("Update Failed");
          }
        }
       
      }
else if (nameChanged == false) {
        print("jkjkk");
      ViewJarsController controller = Get.put(ViewJarsController());
      controller.readData();
      // Get.offAllNamed(AppRoute.companyview);
      Get.back();
      
      Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Data the same", style: TextStyle(color: Colors.white)),
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

  jarModels =Get.arguments["jarModel_"];


     name= TextEditingController();
     price= TextEditingController();



  // get data from db view to texts in edit

    id = jarModels!.id.toString();
    name.text = jarModels!.name.toString();
    price.text = jarModels!.price.toString();


    super.onInit();
  }

  @override
  void dispose() {
   name.dispose();
   price.dispose();

    super.dispose();
  }


}