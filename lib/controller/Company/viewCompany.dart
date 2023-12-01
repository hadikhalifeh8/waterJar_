import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/companyModels.dart';
import 'package:water_jar/data/model/townsModel.dart';

class ViewCompaniesController extends GetxController{
 
  SqlDb sqlDb = SqlDb();
    List<CompanyModels> company = [];
  StatusRequest statusRequest = StatusRequest.none;

  CompanyModels? companyModels;





 Future readData() async {
      company.clear();
       update();
    statusRequest = StatusRequest.loading;

    List<Map> response = await sqlDb.readData("SELECT * FROM company");

      print("***************##############************* Controler $response ");

                                
            statusRequest = handlingData(response); 

             if(StatusRequest.success == statusRequest)
     {       
            if(response.length > 0)
            {
              List listCompanies = response;
            company.addAll(listCompanies.map((e) => CompanyModels.fromJson(e)));  

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

  int response = await sqlDb.deleteData("DELETE  FROM company WHERE id = ${id_.toString()}");

    if(response > 0) {

              company.removeWhere((element) => element.id.toString() == id_.toString() );
             
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
    Get.toNamed(AppRoute.companyadd);
    
  }



    goToEditPage(CompanyModels companyModels)
  {
    Get.toNamed(AppRoute.companyedit, 
                   arguments: {
                    "companyModel_" : companyModels,
                   }
                      );
  }


  @override
  void onInit() {
   readData();
    super.onInit();
  }
}