import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/bottelsModel.dart';
import 'package:water_jar/data/model/districtsModel.dart';

class ViewBottelsController extends GetxController {

  SqlDb sqlDb = SqlDb();
  List<BottelsModel> bottels = [];
  StatusRequest statusRequest = StatusRequest.none;








  Future readData() async{
    bottels.clear(); // for delete refresh
     update();
    statusRequest = StatusRequest.loading;
   

    // List<Map> response = await sqlDb.readData("SELECT * FROM district WHERE id = ");
    List<Map> response = await sqlDb.readData('''
  SELECT bottels.id, bottels.name, bottels.company_id, bottels.price, company.id as company_id, company.name as company_name
  FROM bottels
  JOIN company ON bottels.company_id = company.id;
        ''');

      print("***************##############************* Controler $response ");


           statusRequest = handlingData(response);
           if(StatusRequest.success == statusRequest)
           {
             if(response.length > 0)
             {
                    List listBottels  = response;
            
            bottels.addAll(listBottels.map((e) => BottelsModel.fromJson(e)));
                     
                     update();
                      print("yes has data");
                        return response;
             }else{
               print("No data");
               update();
   
    return  statusRequest = StatusRequest.failure;

             }
            
           }
           update();
            

  }



  
  removeData(id_) async {
  

        int response = await sqlDb.deleteData
                 ('''
                    DELETE FROM bottels 
                    WHERE id = ${id_.toString()}
                ''');
             if(response > 0) {

              bottels.removeWhere((element) => element.id.toString() == id_!.toString() );
             
            //  update();


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
    Get.toNamed(AppRoute.bottelsadd);
  }





    goToEditPage(BottelsModel bottelsModel)
  {
    Get.toNamed(AppRoute.bottelsedit, 
                           arguments: {

                           "bottelsModel_" :bottelsModel, 


  });
  }


   
   @override
  void onInit() {
    readData();
    super.onInit();
  }


}