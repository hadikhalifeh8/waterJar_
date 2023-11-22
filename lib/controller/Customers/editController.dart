import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Customers/viewController.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/core/shared/DropDownSearch.dart';

import 'package:water_jar/data/model/customersModel.dart';

class EditCustomerController extends GetxController {


    SqlDb sqlDb = SqlDb();

  

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  List<CustomersModel> customers = [];
  CustomersModel? customersModel;

  String? id;
  String? townId;
  String? districtId;


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



 resetDistrictDropDown() {
           districtsName.text = "";
           districtsId.text = ""; // Set the ID to an appropriate default value or an empty string
}

// 1-district data according to town data selected(id) معين بيعطيني ال  row أول ما إكبس تعديل ل 
districtFirstappearInEdit(String townId) {

  if (townId.toString() != this.townId.toString()) {
    this.townId = townId.toString();
    getDistrictsData(townId);
    update();
    print("Calling getDistrictsData with townId: ${townId.toString()}");
    if (townsId.text != null && townsId.text.isNotEmpty) {
      dropdownListOFDistricts.clear();
      getDistrictsData(townId);
    }
    update();
  }

}

//2-List of district according to towns data Selected(id) وبرجعلي  resetDistrictDropDown() بيعمل  Town data بس غير ال 
    // Add this function to update districts based on the selected town
   onTownChanged(String? townId)  {
    if (townId != null && townId.isNotEmpty) {
      dropdownListOFDistricts.clear(); // Clear existing districts
      resetDistrictDropDown();
      
      update(); // Update the UI
     
      // Call getDistrictsData with the selected townId
       getDistrictsData(townId);
      
    }
  }





Future getDistrictsData(String townId) async {
  // print("Calling getDistrictsData with townId: $townId");

  update();
  List<Map> response = await sqlDb.readData('''
    SELECT id, name FROM district WHERE town_id = "${townsId.text}"
  ''');

  print("townId is = ${townsId.text}");
  print("district is = ${districtsId.text}");


  print("***************##############************* Districts Controler $response");

  statusRequest = handlingData(response);

  if (StatusRequest.success == statusRequest) {
    dropdownListOFDistricts.clear();

    if (response.length > 0 || response.length != null) {
      customers.clear();
      List listDistricts = response;
      customers.addAll(listDistricts.map((e) => CustomersModel.fromJson(e)));
      update();

      for (int i = 0; i < customers.length; i++) {
        dropdownListOFDistricts.add(SelectedListItem(
          name: customers[i].name.toString(),
          value: customers[i].id.toString(),
        ));
        
      }

      print("yes has districts data");
      update();
      return response;
    }
    print("not > 0 emptyyyyyyyyyyy");
  } else {
    print("No data");
    update();
    return statusRequest = StatusRequest.failure;
  }
  print("======= = =fails");
  return statusRequest = StatusRequest.failure;
}





     


     // Update Data
   updateData(id) async {
        if ( townsId.text.isEmpty ||  districtsId.text.isEmpty) {
  return Get.snackbar("warning", "select a town AND district",backgroundColor: Colors.red, colorText: Colors.white);
}

    if(formState.currentState!.validate()){

      statusRequest = StatusRequest.loading;
      update();


         List<Map> existingrecords = await sqlDb.readData
                            ('''
                             SELECT * FROM customers WHERE id != "${id.toString()}" AND (name = "${name.text}" OR phone = "${phone.text}")
                            ''');
          if(existingrecords.isNotEmpty) {
             statusRequest = StatusRequest.failure;
        Get.defaultDialog(title: "Warning", middleText: "Name OR Phone already exists");
          }else{

        // Fetch the existing values if needed
      List<Map> existingCustomerData = await sqlDb.readData('''
        SELECT name, phone, town_id, district_id FROM customers WHERE id = "${id.toString()}"
      ''');
      String existingName = existingCustomerData[0]['name'].toString();
      String existingPhone = existingCustomerData[0]['phone'].toString();
      int existingTown = existingCustomerData[0]['town_id'];
      int existingDistrict = existingCustomerData[0]['district_id'];



     
      // Check if the name or phone or town or district has changed
      bool nameChanged = name.text != existingName;
      bool phoneChanged = phone.text != existingPhone;
      bool townChanged = townId.toString() != existingTown;
      bool districtChanged = districtId.toString() != existingDistrict;


      if(nameChanged || phoneChanged || townChanged || districtChanged) {

        int response =  await sqlDb.updateData
    ('''
       UPDATE customers SET
            name = "${name.text}",
            phone = "${phone.text}",
            town_id = "${townsId.text}",
            district_id = "${districtsId.text}"
            WHERE id = "${id.toString()}"
           ''');

            print("##########################Controller $response");

            statusRequest = handlingData("// $response //");
           
            if(StatusRequest.success == statusRequest)
            {

                 if(response > 0)
                 {
                    print("Update Successful");
            ViewCustomerController controller = Get.put(ViewCustomerController());
             controller.readDatas();
             print("Update readData");
            Get.offAllNamed(AppRoute.customerview);

             Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Data updated Successfully", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blue.shade400,
            );

                 }
            
            }
       update();

      }
                 update();


          }
      update();
            print("333333333333333");


    }
   }





  @override
  void onInit() async {

        super.onInit();

 customersModel = Get.arguments["customersModel_"];


 await getTownsData();

 // Ensure townsId.text is not null or empty before calling getDistrictsData
  if (townsId.text != null && townsId.text.isNotEmpty) {
    await getDistrictsData(townsId.text);
  }
await districtFirstappearInEdit(townsId.toString());
//onTownChanged(townsId.text);







    
    
  

  

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



    
     // get data from db view to texts in edit
    id = customersModel!.id.toString();

    name.text =  customersModel!.name.toString();
    phone.text =  customersModel!.phone.toString();


    townsName.text =  customersModel!.townName.toString();
    townsId.text =  customersModel!.townId.toString();

    districtsId.text =  customersModel!.districtId.toString();
    districtsName.text =  customersModel!.districtName.toString();

   

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