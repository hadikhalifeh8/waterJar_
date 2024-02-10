import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/jarModels.dart';


class ViewJarsController extends GetxController{
 
  SqlDb sqlDb = SqlDb();
    List<JarModels> jar= [];
  StatusRequest statusRequest = StatusRequest.none;

  JarModels? jarModels;





 Future readData() async {
      jar.clear();
       update();
    statusRequest = StatusRequest.loading;

    List<Map> response = await sqlDb.readData("SELECT * FROM jars");

      print("***************##############************* Controler $response ");

                                
            statusRequest = handlingData(response); 

             if(StatusRequest.success == statusRequest)
     {       
            if(response.length > 0)
            {
              List listCompanies = response;
            jar.addAll(listCompanies.map((e) => JarModels.fromJson(e)));  

            update();
            print("yes has companies data");
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

  int response = await sqlDb.deleteData("DELETE  FROM jars WHERE id = ${id_.toString()}");

    if(response > 0) {

              jar.removeWhere((element) => element.id.toString() == id_.toString() );
             
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
    Get.toNamed(AppRoute.jaradd);
    
  }



    goToEditPage(JarModels jarModels)
  {
    Get.toNamed(AppRoute.jaredit, 
                   arguments: {
                    "jarModel_" : jarModels,
                   }
                      );
  }


  @override
  void onInit() {
   readData();
    super.onInit();
  }
}