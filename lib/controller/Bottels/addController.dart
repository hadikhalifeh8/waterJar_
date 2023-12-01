import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Bottels/viewController.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/bottelsModel.dart';

class AddBottelController extends GetxController {
  
  
 SqlDb sqlDb = SqlDb();
 List<BottelsModel> bottels = [];
   List<SelectedListItem> dropdownList = [];


 StatusRequest statusRequest = StatusRequest.none; 

  GlobalKey<FormState> formState = GlobalKey<FormState>();

   TextEditingController name = TextEditingController();
   TextEditingController price = TextEditingController();


  TextEditingController? companyName;
  TextEditingController? companyId;




  TextEditingController dropdownCompanyName = TextEditingController();
  TextEditingController dropdownCompanyId = TextEditingController();





    Future getCompaniesData() async{

        List<Map> response = await sqlDb.readData("SELECT * FROM company");

      print("***************##############************* Controler $response ");

       statusRequest = handlingData(response); 

             if(StatusRequest.success == statusRequest)
     {       
            if(response.length > 0)
            {
              List listTowns = response;
            bottels.addAll(listTowns.map((e) => BottelsModel.fromJson(e)));  
            update();

             for(int i = 0; i < bottels.length; i++)
       {
          dropdownList.add(SelectedListItem(
                                            name: bottels[i].name.toString(),
                                            value: bottels[i].id.toString(),
                                            )  
                                            );
       }

            print("yes has town data");
            return response;
            }
     }
     else{
        print("No data");
        update();
    return  statusRequest = StatusRequest.failure; 
     }
     update();
     print("======= = =fails");
      return  statusRequest = StatusRequest.failure;
  }





    insertData() async{
if (companyId == null || companyId!.text.isEmpty) {
  return Get.snackbar("warning", "select a company",backgroundColor: Colors.red, colorText: Colors.white);
}

    if(formState.currentState!.validate())
    {
      statusRequest = StatusRequest.loading;
      update();



      List<Map> existingrecords = await sqlDb.readData
                            ('''
                             SELECT * FROM bottels WHERE name = "${name.text}" 
                            ''');
          if(existingrecords.isNotEmpty) {
             statusRequest = StatusRequest.failure;
        Get.defaultDialog(title: "Warning", middleText: "name already exists");
          }else{
                  int response =await sqlDb.insertData('''
                 INSERT INTO bottels('name', 'company_id', 'price')
                 VALUES('${name.text}', '${companyId!.text}', '${price.text}')
              ''');
              

                    print("=*//*--================ $response");   
                                   
           statusRequest = handlingData(response);
           if(StatusRequest.success == statusRequest)
           {
             if(response > 0)
             {
               ViewBottelsController controller = Get.put(ViewBottelsController());
               controller.readData();
               Get.offAllNamed(AppRoute.bottelsview);

                  Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Data added Successfully", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green.shade400,
            );  

             }else {
            print("Status.FAILED");
            statusRequest = StatusRequest.failure;
            Get.defaultDialog(title: "Warning", middleText: "An error occurred while adding data");
          }
           }     
          }                


 update();
    }
    
  }








  @override
  void onInit() {
    getCompaniesData();
       name = TextEditingController();

   companyName =TextEditingController();
   companyId =TextEditingController();


   dropdownCompanyId =TextEditingController();
   dropdownCompanyName =TextEditingController();

    super.onInit();
  }


}