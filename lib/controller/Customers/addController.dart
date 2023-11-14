import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/customersModel.dart';

class AddCustomerController extends GetxController{


  SqlDb sqlDb = SqlDb();

  

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  List<CustomersModel> customers = [];

  List<SelectedListItem> dropdownListOFTowns = [];
  List<SelectedListItem> dropdownListOFDistricts = [];


  StatusRequest statusRequest = StatusRequest.none;

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  TextEditingController dropdownTownsName = TextEditingController();
  TextEditingController dropdownTownsId = TextEditingController();

  TextEditingController dropdownDistrictName = TextEditingController();
  TextEditingController dropdownDistrictId = TextEditingController();

  TextEditingController townsName = TextEditingController();
  TextEditingController townsId = TextEditingController();

  TextEditingController districtsName = TextEditingController();
  TextEditingController districtsId = TextEditingController();



  // get Towns Data
      Future getTownsData() async{


        List<Map> response = await sqlDb.readData("SELECT * FROM towns");

      print("***************##############************* Towns Controler $response ");

       statusRequest = handlingData(response); 

             if(StatusRequest.success == statusRequest)
     {       
            if(response.length > 0)
            {
               customers.clear(); // Clear the list before adding town data
              List listTowns = response;
            customers.addAll(listTowns.map((e) => CustomersModel.fromJson(e)));  
            update();

             for(int i = 0; i < customers.length; i++)
       {
          dropdownListOFTowns.add(SelectedListItem(
                                            name: customers[i].name.toString(),
                                            value: customers[i].id.toString(),
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




    // Add this function to update districts based on the selected town
  void onTownChanged(String? townId) async {
    if (townId != null && townId.isNotEmpty) {
      dropdownListOFDistricts.clear(); // Clear existing districts
   
      update(); // Update the UI
      

      // Call getDistrictsData with the selected townId
      await getDistrictsData(townId);
    }
  }









    // get Districts Data
      Future getDistrictsData(String townId) async{



            List<Map> response = await sqlDb.readData('''

SELECT id, name  FROM district WHERE town_id = "${townsId.text}"
                        ''');
                        print("townsId is = ${townsId.text}");

      print("***************##############************* Districts Controler $response ");

       statusRequest = handlingData(response); 

             if(StatusRequest.success == statusRequest)
     {       
            if(response.length > 0)
            {
              // to not get duplicate data for gettownsdata & getdistrictsdata
              customers.clear(); // Clear the list before adding district data

              List listDistricts = response;
            customers.addAll(listDistricts.map((e) => CustomersModel.fromJson(e)));  
            update();

             for(int i = 0; i < customers.length; i++)
       {
          dropdownListOFDistricts.add(SelectedListItem(
                                            name: customers[i].name.toString(),
                                            value: customers[i].id.toString(),
                                            )  
                                            );
       }
       
       update();

            print("yes has districts data");
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









//    insertData() async {

//     if (townsId == null || townsId.text.isEmpty || districtsId == null || districtsId.text.isEmpty) {
//   return Get.snackbar("warning", "select a town AND district",backgroundColor: Colors.red, colorText: Colors.white);
// }

//     if(formState.currentState!.validate())
//     {
//       statusRequest = StatusRequest.loading;
//       update();



//       List<Map> existingrecords = await sqlDb.readData
//                             ('''
//                              SELECT * FROM customers WHERE name = "${name.text}" OR phone = "${phone.text}"
//                             ''');
//           if(existingrecords.isNotEmpty) {
//              statusRequest = StatusRequest.failure;
//         Get.defaultDialog(title: "Warning", middleText: "Phone number or name already exists");
//           }else{
//                   int response =await sqlDb.insertData 
//                                      ('''
//                                      INSERT INTO customers ('name', 'town_id', 'district_id')
//                                      VALUES ("${name.text}", ${townsId.text}, ${districtsId.text})
//                                   ''');

//           statusRequest = handlingData("// $response //");

//         if (StatusRequest.success == statusRequest) {
//           if (response > 0) {

//             // ViewDistreictsController controller = Get.put(ViewDistreictsController());
//             // print("*---------=== success + $response");
//             // controller.readData();
//             // Get.offAllNamed(AppRoute.districtview);

//             Get.rawSnackbar(
//               titleText: const Text("Success", style: TextStyle(color: Colors.white)),
//               messageText: const Text("Data added Successfully", style: TextStyle(color: Colors.white)),
//               backgroundColor: Colors.green.shade400,
//             );
//           } else {
//             print("Status.FAILED");
//             statusRequest = StatusRequest.failure;
//             Get.defaultDialog(title: "Warning", middleText: "An error occurred while adding data");
//           }
//         }     
                             
//           }                

// update();    

//     }

//   }
  


  @override
  void onInit() {
    getTownsData();
    getDistrictsData(townsId.toString());

    name= TextEditingController();
    phone = TextEditingController();

    dropdownTownsName = TextEditingController();
    dropdownTownsId= TextEditingController();

    townsName= TextEditingController();
    townsId= TextEditingController();

    dropdownDistrictName= TextEditingController();
    dropdownDistrictId= TextEditingController();

    districtsName= TextEditingController();
    districtsId= TextEditingController();


    super.onInit();
  }

  @override
  void dispose() {
   
   name.dispose();
   phone.dispose();

    dropdownTownsName.dispose();
    dropdownTownsId.dispose();

    townsName.dispose();
    townsId.dispose();

    dropdownDistrictName.dispose();
    dropdownDistrictId.dispose();

    districtsName.dispose();
    districtsId.dispose();



    super.dispose();
  }




}