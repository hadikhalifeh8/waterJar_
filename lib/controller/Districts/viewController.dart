import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/districtsModel.dart';

class ViewDistreictsController extends GetxController {

  SqlDb sqlDb = SqlDb();
  List<DistrictsModel> district = [];
  StatusRequest statusRequest = StatusRequest.none;

  // DistrictsModel? districtsModel;


  List listOfTitles =  [
    //group of titles

{"Name" : "#", "id":"1" },
{"Name" : "District Name" , "id":"2"},
{"Name" : "Town Name", "id":"3"},
{"Name" : "eq", "id":"4"},
  ];




  Future readData() async{
    district.clear(); // for delete refresh
    statusRequest = StatusRequest.loading;
    update();

    // List<Map> response = await sqlDb.readData("SELECT * FROM district WHERE id = ");
    List<Map> response = await sqlDb.readData
                                          ('''

  SELECT district.id, district.name, district.town_id, towns.id as town_id, towns.name as town_name
  FROM district
  JOIN towns ON district.town_id = towns.id;
          
    
                       
                                        ''');

      print("***************##############************* Controler $response ");


           statusRequest = handlingData(response);
           if(StatusRequest.success == statusRequest)
           {
             if(response.length > 0)
             {
                    List listDistrict  = response;
            
            district.addAll(listDistrict.map((e) => DistrictsModel.fromJson(e)));
                     
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
                    DELETE FROM district 
                    WHERE id = ${id_.toString()}
                ''');
             if(response > 0) {

              district.removeWhere((element) => element.id.toString() == id_!.toString() );
             
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
    Get.toNamed(AppRoute.districtadd);
  }





    goToEditPage(DistrictsModel districtsModel)
  {
    Get.toNamed(AppRoute.districtedit, 
                           arguments: {

                           "districtsModel_" :districtsModel, 


  });
  }


   
   @override
  void onInit() {
    readData();
    super.onInit();
  }


}