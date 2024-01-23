import 'package:dartz/dartz.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/core/services/services.dart';
import 'package:water_jar/data/model/bottelsModel.dart';
import 'package:water_jar/data/model/companyModels.dart';
import 'package:water_jar/data/model/customersModel.dart';
import 'package:water_jar/data/model/daysModel.dart';
import 'package:water_jar/data/model/districtsModel.dart';
import 'package:water_jar/data/model/driversModel.dart';
import 'package:water_jar/data/model/ordersModel.dart';
import 'package:water_jar/data/model/townsModel.dart';

class AddOrderController extends GetxController {

 SqlDb sqlDb = SqlDb();
  Myservices myservices = Get.find();

 List<DaysModel> day = [];
 DaysModel? daysModel;
   String? dayid;

List<DriversModel> drivers = [];
 DriversModel? driversModel;
    String? driverid;


 TextEditingController qtyOfBottels_ = TextEditingController(text: "0");
 TextEditingController pricePerBottel_ = TextEditingController(text: "0");
 String? totalPriceOfBottels_= "0";

 String? qtyOfJarIn_= "0";
 String? qtyOfJarOut_= "0";
 String? taltalQtyOfJars_= "0";
 String? pricePerJar_= "0";
 String? totalPriceOfJars_= "0";

 






  GlobalKey<FormState> formState = GlobalKey<FormState>();

  List<OrdersModel> orders = [];

  List<CustomersModel> customers = [];
  CustomersModel? customersModel;


  List<TownsModel> towns = [];

  List<DistrictsModel> districts = [];


  List<CompanyModels> companies = [];

  List<BottelsModel> bottels = [];
   BottelsModel? bottelsModel;
  

  List<SelectedListItem> dropdownListOFCustomers = [];
   List<SelectedListItem> dropdownListOFTowns = [];
  List<SelectedListItem> dropdownListOFDistricts = [];


 
  List<SelectedListItem> dropdownListOFCompanies = [];
  List<SelectedListItem> dropdownListOFBottels = [];



  StatusRequest statusRequest = StatusRequest.none;







  TextEditingController dropdownCustomersName = TextEditingController();
  TextEditingController dropdownCustomersId = TextEditingController();

  TextEditingController dropdownTownsName = TextEditingController();
  TextEditingController dropdownTownsId = TextEditingController();


  TextEditingController dropdownDistrictsName = TextEditingController();
  TextEditingController dropdownDistrictsId = TextEditingController();



  TextEditingController dropdownCompaniesName = TextEditingController();
  TextEditingController dropdownCompaniesId = TextEditingController();

  TextEditingController dropdownBottelsName = TextEditingController();
  TextEditingController dropdownBottelsId = TextEditingController();


  TextEditingController customerName = TextEditingController();  
  TextEditingController customerId = TextEditingController();

  TextEditingController townId = TextEditingController();  
  TextEditingController townName = TextEditingController();


  TextEditingController districtId = TextEditingController();  
  TextEditingController districtName = TextEditingController();


  TextEditingController companiesName = TextEditingController();
  TextEditingController companiesId = TextEditingController();

  TextEditingController  bottelsName = TextEditingController();
  TextEditingController  bottelsId = TextEditingController();



  TextEditingController qtyOfBottles = TextEditingController();
  TextEditingController pricePerBottel = TextEditingController();
  TextEditingController totalPriceBottel = TextEditingController();


  TextEditingController jarIn = TextEditingController();
  TextEditingController jarOut = TextEditingController();
  TextEditingController qtyPreviousOFJars = TextEditingController();

  TextEditingController totalJars = TextEditingController();

  TextEditingController pricePerJar = TextEditingController();
  TextEditingController totalPriceJars = TextEditingController();

  TextEditingController totalPrice = TextEditingController();



















    // get Towns Data
 Future getTownsData() async{


List<Map> response = await sqlDb.readData('''
  SELECT * FROM towns
  
  ''');

      print("***************##############************* Towns Controler $response ");

       statusRequest = handlingData(response); 

             if(StatusRequest.success == statusRequest)
     {       
            if(response.length > 0)
            {
               towns.clear(); // Clear the list before adding town data
              List listTowns = response;
            towns.addAll(listTowns.map((e) => TownsModel.fromJson(e)));  
            update();

             for(int i = 0; i < towns.length; i++)
       {
          dropdownListOFTowns.add(SelectedListItem(
                                            name: towns[i].name.toString(),
                                            value: towns[i].id.toString(),
                                            )  
                                            );
       }
            print("yes has Town data");
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



  void resetDistrictANDCustomerDropDown() {
districtName.text = "";
districtId.text = ""; // Set the ID to an appropriate default value or an empty string

customerName.text = "";
      customerId.text = "";
}




    // Add this function to update districts based on the selected town
   onTownChanged(String? townId) async {
    if (townId != null && townId.isNotEmpty) {
      dropdownListOFDistricts.clear(); // Clear existing districts
      dropdownListOFCustomers.clear(); // Clear existing Customers

      
      resetDistrictANDCustomerDropDown();
      

      update(); // Update the UI
     
      

      // Call getDistrictsData with the selected townId
      await getDistrictsData();
      
      
    }
  }





    // get Districts Data
      Future getDistrictsData() async{



            List<Map> response = await sqlDb.readData('''

SELECT id, name  FROM district WHERE town_id = "${townId.text}"
                        ''');
                        print("townsId is = ${townId.text}");
                        

      print("***************##############************* Districts Controler $response ");

       statusRequest = handlingData(response); 

             if(StatusRequest.success == statusRequest)
     {       
            if(response.length > 0)
            {
              // to not get duplicate data for gettownsdata & getdistrictsdata
              districts.clear(); // Clear the list before adding district data

              List listDistricts = response;
            districts.addAll(listDistricts.map((e) => DistrictsModel.fromJson(e)));  
            update();

             for(int i = 0; i < districts.length; i++)
       {
          dropdownListOFDistricts.add(SelectedListItem(
                                            name: districts[i].name.toString(),
                                            value: districts[i].id.toString(),
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


  
void resetCustomerDropDown() {
      customerName.text = "";
      customerId.text = ""; // Set the ID to an appropriate default value or an empty string
}

       // For Customer 
    // Add this function to update districts based on the selected town
   onDistrictChanged( String? districtId) async {
    
    
    
    if (districtId != null && districtId.isNotEmpty) {
      dropdownListOFCustomers.clear(); // Clear existing districts
      resetCustomerDropDown();
      

      update(); // Update the UI
     
      

      // Call getDistrictsData with the selected townId
      // await getTownsData();
      // await getDistrictsData();
      await getCustomersData();
      
      
    }
  }





      // get Customers Data
 Future getCustomersData() async{

       List<Map> response = await sqlDb.readData('''

SELECT id, name  FROM customers WHERE town_id = "${townId.text}" and district_id = "${districtId.text}"
                        ''');
                        print("townsId is = ${townId.text}, &&  the districtId is = ${districtId.text}");
                        

      print("***************##############************* Districts Controler $response ");

       statusRequest = handlingData(response); 

             if(StatusRequest.success == statusRequest)
     {       
            if(response.length > 0)
            {
              // to not get duplicate data for gettownsdata & getdistrictsdata
              customers.clear(); // Clear the list before adding district data

              List listCustomers = response;
            customers.addAll(listCustomers.map((e) => CustomersModel.fromJson(e)));  
            update();

             for(int i = 0; i < listCustomers.length; i++)
       {
          dropdownListOFCustomers.add(SelectedListItem(
                                            name: customers[i].name.toString(),
                                            value: customers[i].id.toString(),
                                            )  
                                            );
       }
       
       update();

            print("yes has customers data");
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



  //get Companies Data
 Future getCompaniesData() async{


List<Map> response = await sqlDb.readData('''
  SELECT * FROM company
  
  ''');

      print("***************##############************* Towns Controler $response ");

       statusRequest = handlingData(response); 

             if(StatusRequest.success == statusRequest)
     {       
            if(response.length > 0)
            {
               companies.clear(); // Clear the list before adding town data
              List listCompanies = response;
            companies.addAll(listCompanies.map((e) => CompanyModels.fromJson(e)));  
            update();

             for(int i = 0; i < companies.length; i++)
       {
          dropdownListOFCompanies.add(SelectedListItem(
                                            name: companies[i].name.toString(),
                                            value: companies[i].id.toString(),
                                            )  
                                            );
       }
            print("yes has Companies data");
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


  

  // resetBottelsDropDown
  void resetBottelsDropDown() {
      bottelsName.text = "";
      bottelsId.text = ""; // Set the ID to an appropriate default value or an empty string
}



       // For Bottels 
    // Add this function to update Company based on the selected town

    //ON Company Changed
   onCompanyChanged( String? companiesId) async {
    
    if (companiesId != null && companiesId.isNotEmpty) {
     
      dropdownListOFBottels.clear(); // Clear existing districts
      resetBottelsDropDown();


      resetBottelPerPrice();
      resetTotalPriceANDQTYOFBottels();

      resetJarPerPrice();
      resetTotalPriceANDQTYSOFJARS();
      
      

      update(); // Update the UI
     
      

      // Call getDistrictsData with the selected townId
      // await getTownsData();
      // await getDistrictsData();
      await getBottelsData();
      
      
    }
  }



 //get Bottels Data
 Future getBottelsData() async{



            List<Map> response = await sqlDb.readData('''

SELECT id, name, price  FROM bottels WHERE company_id = "${companiesId.text}"
                        ''');
                        print("company_id is = ${companiesId.text}");
                        

      print("***************##############************* Companies Controler $response ");

       statusRequest = handlingData(response); 

             if(StatusRequest.success == statusRequest)
     {       
            if(response.length > 0)
            {
              // to not get duplicate data for gettownsdata & getdistrictsdata
              bottels.clear(); // Clear the list before adding district data

              List listBottels = response;
            bottels.addAll(listBottels.map((e) => BottelsModel.fromJson(e)));  
            update();

             for(int i = 0; i < bottels.length; i++)
       {
          dropdownListOFBottels.add(SelectedListItem(
                                            name: bottels[i].name.toString(),
                                            value: bottels[i].id.toString(),
                                            )  
                                            );
       }
       
       update();

            print("yes has bottels data");
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


  // Insert Order Data
   insertData() async {
  if (formState.currentState!.validate()) {
    statusRequest = StatusRequest.loading;
    update();

 
 int response = await sqlDb.insertData(''' INSERT INTO orders (
        'day_id', 'driver_id', 'customer_id', 'town_id', 'district_id','company_id', 'bottle_id',
         'qty_of_bottles', 'price_per_bottel', 'tolal_price_bottel', 'qty_jar_in', 'qty_jar_out', 'qty_previous_jars', 'total_jar',
         'price_per_jar', 'total_price_jars', 'total_price')
          VALUES("${daysModel!.id.toString()}", "${myservices.sharedPreferences.getString("id").toString()}", "${customerId.text}", "${townId.text}", "${districtId.text}", "${companiesId.text}", "${bottelsId.text}",
          "${qtyOfBottles.text}" , "${pricePerBottel.text}", "${totalPriceBottel.text}" ,
           "${jarIn.text}" , "${jarOut.text}", "${qtyPreviousOFJars.text}", "${totalJars.text}",
           "${pricePerJar.text}" , "${totalPriceJars.text}" ,"${totalPrice.text}"
          )
        ''');

        statusRequest = handlingData("// $response //");

        if (StatusRequest.success == statusRequest) {
          if (response > 0) {
           
          //   ViewDriversController controller = Get.put(ViewDriversController());
          //   print("*---------=== success + $response");
          //   controller.readData();
            Get.offNamed(AppRoute.viewdays);
          //    Get.back();


            Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Data added Successfully", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green.shade400,
            );
          } else {
            print("Status.FAILED");
            statusRequest = StatusRequest.failure;
            Get.defaultDialog(title: "Warning", middleText: "An error occurred while adding data");
          }
        }
      
      update();
    } 
    // catch (e) {
    //   print("Error: $e");
    //   update();
    //   statusRequest = StatusRequest.failure;
    //   Get.defaultDialog(title: "Error", middleText: "An error occurred while adding data");
    // }
 // }
}


//**************************************START FOR BOTTELS CALCULATIONS*********************************** */


  void resetBottelPerPrice() {
pricePerBottel.text = "0";

}
  void resetTotalPriceANDQTYOFBottels() {
  totalPriceBottel.text = "0";
 // qtyOfBottles.text = "0";
 if(qtyOfBottles.text.isEmpty || bottelsId.text.isEmpty)
 {
    qtyOfBottles.text = "0";
 }else{
  qtyOfBottles.text = qtyOfBottles.text;
 }

}


    // Add this function to update the price based on the selected bottle
   onBottlesChanged(String? bottelsId) async {
    if (bottelsId != null && bottelsId.isNotEmpty) {
     

      
      resetBottelPerPrice();
      resetTotalPriceANDQTYOFBottels();
      

      update(); // Update the UI
     

      getPricePerBottelData();
      getTotalPriceOfBottelData();
     
    
      
      
    }
  }

    Future getPricePerBottelData() async {
  update();
    List<Map> response = await sqlDb.readData('''
      SELECT bottels.id, bottels.price, bottels.company_id, 
      company.id as company_id, company.name as company_name
           
           FROM bottels
         
         JOIN company ON bottels.company_id = company.id
         WHERE bottels.id = ${bottelsId.text} AND company.name LIKE 'tan%'
      ''');

  if (response.length>0) {
    bottels.clear();

    List listbottels = response;
    bottels.addAll(listbottels.map((e) => BottelsModel.fromJson(e)));
  
       
         for(int i = 0; i < bottels.length ; i++)
         {
          pricePerBottel.text =bottels[i].price.toString();
            print("yehoooo has bottels prices");
         }
      update();
      }else{
        print("noooo hasn't bottels prices");
        pricePerBottel.text ="0";
      }
    

update();
     return response;

  }






      Future getTotalPriceOfBottelData() async {
  update();
    List<Map> response = await sqlDb.readData('''
      SELECT bottels.id, bottels.price, bottels.company_id, 
      company.id as company_id, company.name as company_name
           
           FROM bottels
         
         JOIN company ON bottels.company_id = company.id
         WHERE bottels.id = ${bottelsId.text} AND company.name LIKE 'tan%'
      ''');

  if (response.length>0) {
    bottels.clear();

    List listbottels = response;
    bottels.addAll(listbottels.map((e) => BottelsModel.fromJson(e)));
  
       
         for(int i = 0; i < bottels.length ; i++)
         {
        //  pricePerBottel.text =bottels[i].price.toString();
 if(qtyOfBottles.text.isEmpty)
 {

totalPriceBottel.text ="0";
 }else{
       totalPriceBottel.text = (int.parse(qtyOfBottles.text) * double.parse(pricePerBottel.text)).toString();
            print("yesssss has bottels totalPriceBottel");

 }




         }
      update();
      }else{
        print("noooo hasn't bottels totalPriceBottel");
        totalPriceBottel.text ="0";
      }
    

update();
     return response;

  }

//**************************************END FOR BOTTELS CALCULATIONS************************************* */




//**************************************START FOR JARS CALCULATIONS************************************** */


  void resetTotalPriceANDQTYSOFJARS() {
  totalPriceJars.text = "0";
 // qtyOfBottles.text = "0";
 if(jarIn.text.isEmpty || jarOut.text.isEmpty || bottelsId.text.isEmpty)
 {
    jarIn.text = "0";
    jarOut.text = "0";
    qtyPreviousOFJars.text = "0";

 }else{

      jarIn.text = jarIn.text;
      jarOut.text = jarOut.text;
      qtyPreviousOFJars.text = qtyPreviousOFJars.text ;

 }

}




  void resetJarPerPrice() {
pricePerJar.text = "0";

}



    // Add this function to update the price based on the selected bottle
   onBottlesFORJARChanged(String? bottelsId) async {
    if (bottelsId != null && bottelsId.isNotEmpty) {
     

      
      resetBottelPerPrice();
      resetTotalPriceANDQTYSOFJARS();
      

      update(); // Update the UI
     

      getPricePerJarData();
      getTotalPriceOfJARData();
      getTotalQTYOFJARSSData();
      getTotalPrice();
     
    
      
      
    }
  }




    Future getPricePerJarData() async {
  update();
    List<Map> response = await sqlDb.readData('''
      SELECT bottels.id, bottels.price, bottels.company_id, 
      company.id as company_id, company.name as company_name
           
           FROM bottels
         
         JOIN company ON bottels.company_id = company.id
         WHERE bottels.id = ${bottelsId.text} AND company.name LIKE 'ser%'
      ''');

  if (response.length>0) {
    bottels.clear();

    List listbottels = response;
    bottels.addAll(listbottels.map((e) => BottelsModel.fromJson(e)));
  
       
         for(int i = 0; i < bottels.length ; i++)
         {
          pricePerJar.text =bottels[i].price.toString();
            print("yehoooo has jar prices");
         }
      update();
      }else{
        print("noooo hasn't jar prices");
       // pricePerBottel.text ="0";
      }
    

update();
     return response;

  }




  Future getTotalPriceOfJARData() async {
    update();
    List<Map> response = await sqlDb.readData('''
      SELECT bottels.id, bottels.price, bottels.company_id, 
      company.id as company_id, company.name as company_name
           
           FROM bottels
         
         JOIN company ON bottels.company_id = company.id
         WHERE bottels.id = ${bottelsId.text} AND company.name LIKE 'ser%'
      ''');

  if (response.length>0) {
    bottels.clear();

    List listbottels = response;
    bottels.addAll(listbottels.map((e) => BottelsModel.fromJson(e)));
  
       
         for(int i = 0; i < bottels.length ; i++)
         {
        //  pricePerBottel.text =bottels[i].price.toString();

     totalPriceJars.text = (int.parse(jarIn.text) * double.parse(pricePerJar.text)).toString();
            print("yesssss has jars totalPriceJar");

         }
      update();
      }else{
        print("noooo hasn't jars totalPriceJar");
        totalPriceJars.text ="0";
      }
    

update();
     return response;

  }




   Future getTotalQTYOFJARSSData() async {
    update();
    List<Map> response = await sqlDb.readData('''
      SELECT bottels.id, bottels.price, bottels.company_id, 
      company.id as company_id, company.name as company_name
           
           FROM bottels
         
         JOIN company ON bottels.company_id = company.id
         WHERE bottels.id = ${bottelsId.text} AND company.name LIKE 'ser%'
      ''');

  if (response.length>0) {
    bottels.clear();

    List listbottels = response;
    bottels.addAll(listbottels.map((e) => BottelsModel.fromJson(e)));
  
       
         for(int i = 0; i < bottels.length ; i++)
         {
        //  pricePerBottel.text =bottels[i].price.toString();

     totalJars.text = (int.parse(jarIn.text) + int.parse(qtyPreviousOFJars.text)- int.parse(jarOut.text)).toString();
            print("yesssss has jars totalJars");

         }
      update();
      }else{
        print("noooo hasn't jars totalJars");
        totalPriceJars.text ="0";
      }
    

update();
     return response;

  } 





     Future getTotalPrice() async {
    update();
    List<Map> response = await sqlDb.readData('''
      SELECT bottels.id, bottels.price, bottels.company_id, 
      company.id as company_id, company.name as company_name
           
           FROM bottels
         
         JOIN company ON bottels.company_id = company.id
         WHERE bottels.id = ${bottelsId.text} AND company.name LIKE 'ser%'
      ''');

  if (response.length>0) {
    bottels.clear();

    List listbottels = response;
    bottels.addAll(listbottels.map((e) => BottelsModel.fromJson(e)));
  
       
         for(int i = 0; i < bottels.length ; i++)
         {
        //  pricePerBottel.text =bottels[i].price.toString();

     totalPrice.text = (double.parse(totalPriceBottel.text) + double.parse(totalPriceJars.text)).toString();
            print("yesssss has jars totalJars");

         }
      update();
      }else{
        print("noooo hasn't jars totalJars");
        totalPriceJars.text ="0";
      }
    

update();
     return response;

  } 






  // removeData() async {
  

  //       int response = await sqlDb.deleteData
  //                ('''
  //                   DELETE  FROM orders WHERE id = 1
                   
  //               ''');
  //            if(response > 0) {

             
             
  //           //  update();


  //          //   print("========***** DELETED $response + $id_");
  //           //   readData();
              
              
  //             Get.snackbar("success", "Data Deleted", backgroundColor: Colors.red,colorText: Colors.white);
           
  //             return response; 
            
  //            }else{
            

  //            } 
  
  //  update();
  //    return  statusRequest = StatusRequest.failure;

            
             
  // }
  






  @override
  void onInit() {
   daysModel = Get.arguments['daysModel_'];
   // customersModel = Get.arguments['customersModel_']; // From View Customer

   getTownsData();
   getDistrictsData();
   getCustomersData();
   getCompaniesData();
   getBottelsData();

   
  // removeData();

  




    qtyOfBottles= TextEditingController();
    pricePerBottel = TextEditingController();
    totalPriceBottel = TextEditingController();


    jarIn= TextEditingController();
    jarOut = TextEditingController();
    qtyPreviousOFJars = TextEditingController();

    totalJars= TextEditingController();

    pricePerJar= TextEditingController();
    totalPriceJars = TextEditingController();





    townId = TextEditingController(); 
    townName = TextEditingController();

    districtId = TextEditingController(); 
    districtName = TextEditingController();

    customerName = TextEditingController(); 
    customerId = TextEditingController();




    dropdownTownsId = TextEditingController();
    dropdownTownsName = TextEditingController();

    dropdownDistrictsId = TextEditingController();
    dropdownDistrictsName = TextEditingController();

    dropdownCustomersName = TextEditingController();
    dropdownCustomersId = TextEditingController();

    dropdownCompaniesName = TextEditingController();
    dropdownCompaniesId = TextEditingController();

    companiesName= TextEditingController();
    companiesId= TextEditingController();

    dropdownBottelsName = TextEditingController();
    dropdownBottelsId = TextEditingController();

    bottelsName= TextEditingController();
    bottelsId= TextEditingController();



    totalPrice = TextEditingController();




    super.onInit();
  }

}