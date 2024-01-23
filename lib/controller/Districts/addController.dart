import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Districts/viewController.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/districtsModel.dart';
import 'package:drop_down_list/drop_down_list.dart';

class AddDistrictController extends GetxController {

  SqlDb sqlDb = SqlDb();


  List<DistrictsModel> district = [];
  List<SelectedListItem> dropdownList = [];



  StatusRequest statusRequest = StatusRequest.none;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  

  TextEditingController dropdownName = TextEditingController();
  TextEditingController dropdownId = TextEditingController();


  TextEditingController? townsName;
  TextEditingController? townsId;




  Future getTownsData() async{

        List<Map> response = await sqlDb.readData("SELECT * FROM towns");

      print("***************##############************* Controler $response ");

       statusRequest = handlingData(response); 

             if(StatusRequest.success == statusRequest)
     {       
            if(response.length > 0)
            {
              List listTowns = response;
            district.addAll(listTowns.map((e) => DistrictsModel.fromJson(e)));  
            update();

             for(int i = 0; i < district.length; i++)
       {
          dropdownList.add(SelectedListItem(
                                            name: district[i].name.toString(),
                                            value: district[i].id.toString(),
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
if (townsId == null || townsId!.text.isEmpty) {
  return Get.snackbar("warning", "select a town",backgroundColor: Colors.red, colorText: Colors.white);
}

    if(formState.currentState!.validate())
    {
      statusRequest = StatusRequest.loading;
      update();



      List<Map> existingrecords = await sqlDb.readData
                            ('''
                             SELECT * FROM district WHERE name = '${name.text}'
                            ''');
          if(existingrecords.isNotEmpty) {
             statusRequest = StatusRequest.failure;
        Get.defaultDialog(title: "Warning", middleText: "name already exists");
          }else{
                  int response =await sqlDb.insertData('''
                 INSERT INTO district('name', 'town_id')
                 VALUES('${name.text}', '${townsId!.text}')
              ''');
              

                    print("=*//*--================ $response");   
                                   
           statusRequest = handlingData(response);
           if(StatusRequest.success == statusRequest)
           {
             if(response > 0)
             {
               ViewDistreictsController controller = Get.put(ViewDistreictsController());
               controller.readData();
              //  Get.offAllNamed(AppRoute.districtview);
              Get.back();

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
    getTownsData();
   
   name = TextEditingController();

   townsName =TextEditingController();
   townsId =TextEditingController();


   dropdownName =TextEditingController();
   dropdownId =TextEditingController();

    super.onInit();
  }


  @override
  void dispose() {
    name.dispose();
  
    dropdownName.dispose();
    dropdownId.dispose();

    townsName!.dispose();
    townsId!.dispose();

    super.dispose();
  }


}