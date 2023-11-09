import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/driversModel.dart';

class ViewDriversController extends GetxController {

  SqlDb sqlDb = SqlDb();
  List<DriversModel> driver = [];
 late StatusRequest statusRequest;

  String? id_;

  DriversModel? driversModel;

  Future readData() async {
    driver.clear();
    update();
    statusRequest =StatusRequest.loading;
     

    List<Map> response = await sqlDb.readData("SELECT * FROM drivers");
       

      print("***************##############************* Controler $response ");
    
     statusRequest = handlingData(response); 


     if(StatusRequest.success == statusRequest)
     {
       
            if(response.length > 0)

       {
            List listDrivers = response;
    driver.addAll(listDrivers.map((e) => DriversModel.fromJson(e)));
     update();
  print("yes has data");
    return response;
    
        
       }else{
        print("No data");
        update();
    return  statusRequest = StatusRequest.failure;
  

     }
     
     }
     print("=======nos datas");
  update();

   
  }



  removeData(id_) async {
  

        int response = await sqlDb.deleteData
                 ('''
                    DELETE FROM drivers 
                    WHERE id = ${id_.toString()}
                ''');
             if(response > 0) {

              driver.removeWhere((element) => element.id.toString() == id_!.toString() );
             
             update();


              print("========***** DELETED $response + $id_");
               readData();
              
              
              Get.snackbar("success", "Data Deleted", backgroundColor: Colors.red,colorText: Colors.white);
           
              return response; 
            
             }else{
            

             } 
  
  //  update();
  //    return  statusRequest = StatusRequest.failure;

            
             
  }




  goToaddPage()
  {
    Get.toNamed(AppRoute.driveradd);
  }

  goToEditPage(DriversModel driversModel)
  {
    Get.toNamed(AppRoute.driveredit, 
             
             arguments: {
              'driversModel_' : driversModel
    
    });
           
  }

  @override
  void onInit() {
    readData();
    
    super.onInit();
  }

}