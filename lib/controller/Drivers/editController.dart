import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Drivers/viewController.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/driversModel.dart';

class EditDriverController extends GetxController{

  SqlDb sqlDb = SqlDb();
  List<DriversModel> driver = [];
  DriversModel? driversModel;
  StatusRequest statusRequest = StatusRequest.none;

  String? id;

  bool isShowPassword = true;

  showPassword(){
   isShowPassword = isShowPassword == true ? false : true;
   update();
  }


  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();






      updateData(id) async {
  if (formState.currentState!.validate()) {
    statusRequest = StatusRequest.loading;
    update();

    
    // Check if the phone number or name already exists
    List<Map> existingRecords = await sqlDb.readData('''
      SELECT * FROM drivers WHERE id != "${id}" AND (name = "${name.text}" OR phone = "${phone.text}")
    ''');

    if (existingRecords.isNotEmpty) {
      statusRequest = StatusRequest.failure;
      Get.defaultDialog(title: "Warning", middleText: "Phone number or name already exists");
    } else {
     
      // Fetch the existing values if needed
      List<Map> existingDriverData = await sqlDb.readData('''
        SELECT name, phone, password FROM drivers WHERE id = "${id.toString()}"
      ''');
      String existingName = existingDriverData[0]['name'];
      String existingPhone = existingDriverData[0]['phone'];
      String existingPassword = existingDriverData[0]['password'];


     
      // Check if the name or phone has changed
      bool nameChanged = name.text != existingName;
      bool phoneChanged = phone.text != existingPhone;
      bool passwordChanged = password.text != existingPassword;


     
      // If either name or phone has changed, perform the update
      if (nameChanged || phoneChanged || passwordChanged == true) {
        int response = await sqlDb.updateData('''
          UPDATE drivers SET
            name = "${name.text}",
            phone = "${phone.text}",
            password = "${password.text}"
          WHERE id = "${id.toString()}"
        ''');

        statusRequest = handlingData("// $response //");

        if (StatusRequest.success == statusRequest) {
          if (response > 0) {
            print("Update Successful");
            ViewDriversController controller = Get.put(ViewDriversController());
            controller.readData();
            //  Get.toNamed(AppRoute.driversview);
            Get.back();

                   Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Data Updated Successfully", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blue.shade400,
            );
        
          } 
        }
       
      }
      else if (nameChanged || phoneChanged || passwordChanged == false){
                  print("jkjkk");
      ViewDriversController controller = Get.put(ViewDriversController());
      controller.readData();
      //  Get.toNamed(AppRoute.driversview);
      Get.back();
      

      
      Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Data the same", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blue.shade400,
            );
      }


    }
    update();
  }
 
}


      @override
  void onInit() {

   driversModel = Get.arguments['driversModel_'];
   
   name     = TextEditingController();
   phone    = TextEditingController();
   password = TextEditingController();


  // get data from db view to texts in edit
    id = driversModel!.id.toString();
    name.text =  driversModel!.name.toString();
    phone.text =  driversModel!.phone.toString();
    password.text =  driversModel!.password.toString();



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