

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

class EditCompanyController extends GetxController {
  
  SqlDb sqlDb = SqlDb();
  
  List<CompanyModels> company = [];

  CompanyModels? companyModels;



  StatusRequest statusRequest = StatusRequest.none;

 // GlobalKey<FormState> formState = GlobalKey<FormState>();
 final formState = GlobalKey<FormState>();

  TextEditingController name =TextEditingController();

   String? id;


      updateData(id) async {
  if (formState.currentState!.validate()) {
    statusRequest = StatusRequest.loading;
    update();

    
    // Check if the phone number or name already exists
    List<Map> existingRecords = await sqlDb.readData('''
      SELECT * FROM company WHERE id != "${id}" AND (name = "${name.text}" )
    ''');

    if (existingRecords.isNotEmpty) {
      statusRequest = StatusRequest.failure;
      Get.defaultDialog(title: "Warning", middleText: "name already exists");
    } else {
     
      // Fetch the existing values if needed
      List<Map> existingDriverData = await sqlDb.readData('''
        SELECT name FROM company WHERE id = "${id.toString()}"
      ''');
      String existingName = existingDriverData[0]['name'];



     
      // Check if the name or phone has changed
      bool nameChanged = name.text != existingName;



     
      // If either name or phone has changed, perform the update
      if (nameChanged) {
        int response = await sqlDb.updateData('''
          UPDATE company SET
            name = "${name.text}"
          WHERE id = "${id.toString()}"
        ''');

        statusRequest = handlingData("// $response //");

        if (StatusRequest.success == statusRequest) {
          if (response > 0) {
            print("Update Successful");
            ViewCompaniesController controller = Get.put(ViewCompaniesController());
            controller.readData();
            Get.offAllNamed(AppRoute.companyview);
          } else {
            print("Update Failed");
          }
        }
       
      }
      print("jkjkk");
      ViewCompaniesController controller = Get.put(ViewCompaniesController());
      controller.readData();
      Get.offAllNamed(AppRoute.companyview);
      
      Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Data Updated Successfully", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green.shade400,
            );
    }
    update();
  }
}

  @override
  void onInit() {

  companyModels =Get.arguments["companyModel_"];


     name= TextEditingController();


  // get data from db view to texts in edit
    id = companyModels!.id.toString();
    name.text =  companyModels!.name.toString();

    super.onInit();
  }

  @override
  void dispose() {
   name.dispose();
    super.dispose();
  }


}