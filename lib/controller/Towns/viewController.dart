import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/townsModel.dart';

class ViewTownsController extends GetxController{
 
  SqlDb sqlDb = SqlDb();
  List<TownsModel> towns = [];

  StatusRequest statusRequest = StatusRequest.none;

  TownsModel? townsModel;





 Future readData() async {
      towns.clear();
       update();
    statusRequest = StatusRequest.loading;

    List<Map> response = await sqlDb.readData("SELECT * FROM towns");

      print("***************##############************* Controler $response ");

                                
            statusRequest = handlingData(response); 

             if(StatusRequest.success == statusRequest)
     {       
            if(response.length > 0)
            {
              List listTowns = response;
            towns.addAll(listTowns.map((e) => TownsModel.fromJson(e)));  

            update();
            print("yes has town data");
            return response;
            }else{
        print("No data");
        update();
    return  statusRequest = StatusRequest.failure;
  

     } 
     }
     update();
     print("======= = =fails");
      return  statusRequest = StatusRequest.failure;
  }


 deleteData(String id_) async {

  int response = await sqlDb.deleteData("DELETE  FROM towns WHERE id = ${id_.toString()}");

    if(response > 0) {

              towns.removeWhere((element) => element.id.toString() == id_.toString() );
             
             update();


              print("========***** DELETED $response + $id_");
               readData();
              
              
              Get.snackbar("success", "Data Deleted", backgroundColor: Colors.red,colorText: Colors.white);
           
              return response; 
            
             }
             update();

 }


  goToaddPage()
  {
    Get.toNamed(AppRoute.townadd);
    
  }


  @override
  void onInit() {
   readData();
    super.onInit();
  }
}