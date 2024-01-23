import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Districts/viewController.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/districtsModel.dart';

class EditDistrictController extends GetxController{

  SqlDb sqlDb = SqlDb();
    List<DistrictsModel> district = [];
     List<SelectedListItem> dropdownList = [];

     String? id;

     
  StatusRequest statusRequest = StatusRequest.none;
  DistrictsModel? districtsModel;

    GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  

  TextEditingController dropdownName = TextEditingController();
  TextEditingController dropdownId = TextEditingController();

  TextEditingController townsName = TextEditingController();
  TextEditingController townsId = TextEditingController();
  





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


  


  updateData(id) async {
    if(formState.currentState!.validate()){

      statusRequest = StatusRequest.loading;
      update();

      List<Map> existingrecords = await sqlDb.readData
                            ('''
                             SELECT * FROM district WHERE id != "${id}" AND (name = "${name.text}")
                            ''');
          if(existingrecords.isNotEmpty) {
             statusRequest = StatusRequest.failure;
        Get.defaultDialog(title: "Warning", middleText: "name already exists");
          }else{

      
        // Fetch the existing values if needed
      List<Map> existingDistrictsData = await sqlDb.readData('''
        SELECT name, town_id FROM district WHERE id = "${id.toString()}"
      ''');
      String existingName = existingDistrictsData[0]['name'];
       int existingTownId = existingDistrictsData[0]['town_id'];

      

     
      // Check if the name has changed
      bool nameChanged = name.text != existingName;
      bool townIdChanged = townsId.text  != existingTownId;


      if(nameChanged || townIdChanged){

      int response = await sqlDb.updateData('''
          UPDATE district SET
            name = "${name.text}",
            town_id = "${townsId.text}"
            WHERE id = "${id.toString()}"
        ''');
        

        print("##########################Controller ${name.text}, ${townsId.text}, ${townsName.text}");

         statusRequest = handlingData("// $response //");

         if (StatusRequest.success == statusRequest) {
         if(response > 0) 
         {
            print("Update Successful");
            ViewDistreictsController controller = Get.put(ViewDistreictsController());
             controller.readData();
             print("Update readData");
            // Get.offAllNamed(AppRoute.districtview);
            Get.back();

             Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Data updated Successfully", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blue.shade400,
            );


         }
      }
      }
      // else{
        
      //  print("The Same Data");
      // ViewDistreictsController controller = Get.put(ViewDistreictsController());
      // controller.readData();
      // Get.offAllNamed(AppRoute.districtview);
      
      // Get.rawSnackbar(
      //         titleText: const Text("Success", style: TextStyle(color: Colors.white)),
      //         messageText: const Text("Data are the Same", style: TextStyle(color: Colors.white)),
      //         backgroundColor: Colors.green.shade400,
      //       );
      // }

  update();

          }
          update();
      
    }
    
  }

  @override
  void onInit() {
    districtsModel = Get.arguments["districtsModel_"];

    getTownsData();

    

   name = TextEditingController();

   townsName =TextEditingController();
   townsId =TextEditingController();


   dropdownName =TextEditingController();
   dropdownId =TextEditingController();


     // get data from db view to texts in edit
    id = districtsModel!.id.toString();
    name.text =  districtsModel!.name.toString();
    townsName.text =  districtsModel!.townName.toString();
    townsId.text =  districtsModel!.townId.toString();
    
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();

    townsName.dispose();
    townsId.dispose();

    dropdownId.dispose();
    dropdownName.dispose();

    super.dispose();
  }
}