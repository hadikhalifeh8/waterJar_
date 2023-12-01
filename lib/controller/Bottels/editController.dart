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


class EditBottelController extends GetxController{

  SqlDb sqlDb = SqlDb();
    List<BottelsModel> bottels = [];
     List<SelectedListItem> dropdownList = [];

     String? id;

     
  StatusRequest statusRequest = StatusRequest.none;
  BottelsModel? bottelsModel;

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


  


  updateData(id) async {
    if (companyId == null || companyId!.text.isEmpty) {
  return Get.snackbar("warning", "select a company",backgroundColor: Colors.red, colorText: Colors.white);
}

    if(formState.currentState!.validate()){

      statusRequest = StatusRequest.loading;
      update();

      List<Map> existingrecords = await sqlDb.readData
                            ('''
                             SELECT * FROM bottels WHERE id != "${id}" AND (name = "${name.text}")
                            ''');
          if(existingrecords.isNotEmpty) {
             statusRequest = StatusRequest.failure;
        Get.defaultDialog(title: "Warning", middleText: "name already exists");
          }else{

      
        // Fetch the existing values if needed
      List<Map> existingBottelsData = await sqlDb.readData('''
        SELECT name, company_id, price FROM bottels WHERE id = "${id.toString()}"
      ''');
      String existingName = existingBottelsData[0]['name'];
       int existingCompanyId = existingBottelsData[0]['company_id'];
       double existingPrice = existingBottelsData[0]['price'];


      

     
      // Check if the name has changed
      bool nameChanged = name.text != existingName;
      bool companyIdChanged = companyId!.text  != existingCompanyId;
      bool priceChanged = price.text  != existingPrice;



      if(nameChanged || companyIdChanged || priceChanged){

      int response = await sqlDb.updateData('''
          UPDATE bottels SET
            name = "${name.text}",
            company_id = "${companyId!.text}",
            price = "${price.text}"

            WHERE id = "${id.toString()}"
        ''');
        

        print("##########################Controller ${name.text}, ${companyId!.text}, ${price.text}");

         statusRequest = handlingData("// $response //");

         if (StatusRequest.success == statusRequest) {
         if(response > 0) 
         {
            print("Update Successful");
            ViewBottelsController controller = Get.put(ViewBottelsController());
             controller.readData();
             print("Update readData");
            Get.offAllNamed(AppRoute.bottelsview);

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
    bottelsModel = Get.arguments["bottelsModel_"];

   

    
    getCompaniesData();
       name = TextEditingController();
       price = TextEditingController();


   companyName =TextEditingController();
   companyId =TextEditingController();


   dropdownCompanyId =TextEditingController();
   dropdownCompanyName =TextEditingController();


     // get data from db view to texts in edit
    id = bottelsModel!.id.toString();
    name.text =  bottelsModel!.name.toString();
    companyId!.text =  bottelsModel!.companyId.toString();
    companyName!.text =  bottelsModel!.companyName.toString();
    price.text =  bottelsModel!.price.toString();

    
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    companyId!.dispose();
    companyName!.dispose();

    dropdownCompanyId.dispose();
    dropdownCompanyName.dispose();

    super.dispose();
  }
}