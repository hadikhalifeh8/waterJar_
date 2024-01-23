import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:water_jar/controller/Drivers/viewController.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/driversModel.dart';

class AddDriverController extends GetxController{

  SqlDb sqlDb = SqlDb();
  List<DriversModel> drivers = [];

  StatusRequest statusRequest = StatusRequest.none;

  bool isShowPassword = true;

  showPassword(){
   isShowPassword = isShowPassword == true ? false : true;
   update();
  }


  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();






 insertData() async {
  if (formState.currentState!.validate()) {
    statusRequest = StatusRequest.loading;
    update();

    //try {
      // Check if the phone number or name already exists
      List<Map> existingRecords = await sqlDb.readData('''
        SELECT * FROM drivers WHERE name = "${name.text}" OR phone = "${phone.text}"
      ''');

      if (existingRecords.isNotEmpty) {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(title: "Warning", middleText: "Phone number or name already exists");
      } else {
        int response = await sqlDb.insertData('''
          INSERT INTO drivers ('name', 'phone', 'password')
          VALUES("${name.text}", "${phone.text}", "${password.text}")
        ''');

        statusRequest = handlingData("// $response //");

        if (StatusRequest.success == statusRequest) {
          if (response > 0) {
           
            ViewDriversController controller = Get.put(ViewDriversController());
            print("*---------=== success + $response");
            controller.readData();
           //  Get.offNamed(AppRoute.driversview);
             Get.back();


            Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Data added Successfully", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green.shade400,
            );
          } else {
            print("Status.FAILED");
            statusRequest = StatusRequest.failure;
            Get.defaultDialog(title: "Warning", middleText: "An error occurred while adding data");
          }
        }
      }
      update();
    } 
    // catch (e) {
    //   print("Error: $e");
    //   update();
    //   statusRequest = StatusRequest.failure;
    //   Get.defaultDialog(title: "Error", middleText: "An error occurred while adding data");
    // }
 // }
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