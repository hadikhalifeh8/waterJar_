import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Orders/viewController.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/core/services/services.dart';
import 'package:water_jar/data/model/bottelsModel.dart';
import 'package:water_jar/data/model/jarModels.dart';
import 'package:water_jar/data/model/customersModel.dart';
import 'package:water_jar/data/model/daysModel.dart';
import 'package:water_jar/data/model/districtsModel.dart';
import 'package:water_jar/data/model/driversModel.dart';
import 'package:water_jar/data/model/ordersModel.dart';
import 'package:water_jar/data/model/townsModel.dart';

class EditOrderController extends GetxController {

 SqlDb sqlDb = SqlDb();
  Myservices myservices = Get.find();

 List<DaysModel> day = [];
  DaysModel? daysModel;


List<DriversModel> drivers = [];
 DriversModel? driversModel;

 String? id;
   



  GlobalKey<FormState> formState = GlobalKey<FormState>();

  List<OrdersModel> orders = [];
  OrdersModel? ordersModel;

  List<CustomersModel> customers = [];
  CustomersModel? customersModel;


  List<TownsModel> towns = [];

  List<DistrictsModel> districts = [];


  List<JarModels> jar = [];
  JarModels? jarModels;

  List<BottelsModel> bottels = [];
   BottelsModel? bottelsModel;
  

  List<SelectedListItem> dropdownListOFCustomers = [];
  //  List<SelectedListItem> dropdownListOFTowns = [];
  // List<SelectedListItem> dropdownListOFDistricts = [];


  List<SelectedListItem> dropdownListOFBottels = [];



  StatusRequest statusRequest = StatusRequest.none;




  // TextEditingController dropdownCustomersName = TextEditingController();
  // TextEditingController dropdownCustomersId = TextEditingController();

    TextEditingController dayId = TextEditingController();  
  TextEditingController dayName = TextEditingController();
  



  TextEditingController dropdownBottelsName = TextEditingController();
  TextEditingController dropdownBottelsId = TextEditingController();


  TextEditingController customerName = TextEditingController();  
  TextEditingController customerId = TextEditingController();

  TextEditingController townId = TextEditingController();  
  TextEditingController townName = TextEditingController();


  TextEditingController districtId = TextEditingController();  
  TextEditingController districtName = TextEditingController();


  TextEditingController jarsName = TextEditingController();
  TextEditingController jarsId = TextEditingController();

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

    TextEditingController oldDebt = TextEditingController();
    TextEditingController newDebt = TextEditingController();

  TextEditingController paid = TextEditingController();

  TextEditingController totalPrice = TextEditingController();







 bool showContainerA = false;
 bool showContainerB = false;

  void toggleContainers(bool showA, bool showB) {
   
      showContainerA = showA;
      showContainerB = showB;
      update();
   
  }




 // get Customers Data
 Future getCustomersData() async{


       List<Map> response = await sqlDb.readData('''

  SELECT customers.id, customers.name, customers.phone, customers.town_id, customers.district_id,
         towns.id as town_id, towns.name as town_name,
         district.id as district_id, district.name as district_name, district.town_id as town_id
         

  FROM customers
  JOIN towns ON customers.town_id = towns.id
  JOIN district ON customers.district_id =  district.id

 
  

                        ''');
                        
                        

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


       
  if (listCustomers.isNotEmpty) {
        int selectedIndex = dropdownListOFCustomers.indexWhere(
            (element) => element.value == customerId.text);

        if (selectedIndex != -1) {
          townId.text = customers[selectedIndex].townId.toString();
          townName.text = customers[selectedIndex].townName.toString();

          districtId.text = customers[selectedIndex].districtId.toString();
          districtName.text = customers[selectedIndex].districtName.toString();

        }
      }
       print("townsId is = ${townId.text}, &&  the districtId is = ${districtId.text}");
       
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




    // Add this function to update districts based on the selected town
   onCustomerChanged( String? customerId) async {
    
    
    
    if (customerId != null && customerId.isNotEmpty) {
      dropdownListOFCustomers.clear(); // Clear existing districts
      // resetCustomerDropDown();
      update(); // Update the UI
      // Call getDistrictsData with the selected townId
      // await getTownsData();
      // await getDistrictsData();
      await getCustomersData();
      
      
    }
  }









 //get Bottels Data
 Future getBottelsData() async{



            List<Map> response = await sqlDb.readData('''

SELECT * FROM bottels
                        ''');
                        // print("company_id is = ${companiesId.text}");
                        

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


  // Update Order Data
   updateData(id) async {

//         if (customerId.text.isEmpty) {
//   return Get.snackbar("warning", "select a customer",backgroundColor: Colors.red, colorText: Colors.white);
// }

     if (bottelsId.text.isEmpty && jarsId.text.isEmpty) {
  return Get.snackbar("warning", "choose bottles OR jars",backgroundColor: Colors.red, colorText: Colors.white);
}

  if (formState.currentState!.validate()) {
    statusRequest = StatusRequest.loading;
    update();

 
 int response = await sqlDb.updateData('''
 UPDATE orders SET 
                  day_id = "${ordersModel!.dayId}",
                  driver_id = "${myservices.sharedPreferences.getString("id")}",
                  customer_id = "${customerId.text}",
                  town_id = "${townId.text}",
                  district_id = "${districtId.text}",
                  jar_id = "${jarsId.text}",
                  bottle_id = "${bottelsId.text}",
                  qty_of_bottles = "${qtyOfBottles.text}",
                  price_per_bottel = "${pricePerBottel.text}",
                  tolal_price_bottel = "${totalPriceBottel.text}",
                  qty_jar_in =  "${jarIn.text}",
                  qty_jar_out = "${jarOut.text}",
                  qty_previous_jars = "${qtyPreviousOFJars.text}",
                  total_jar = "${totalJars.text}",
                  price_per_jar = "${pricePerJar.text}",
                  total_price_jars = "${totalPriceJars.text}",
                  old_debt = "${oldDebt.text}",
                  new_debt = "${newDebt.text}",

                  paid = "${paid.text}",
                  total_price = "${totalPrice.text}"
                  
                  WHERE id = ${id.toString()}
          
        ''');

        statusRequest = handlingData("// $response //"); 

        if (StatusRequest.success == statusRequest) {
          if (response > 0) {
           
             ViewOrdersController controller = Get.put(ViewOrdersController());
            print("*---------=== success + $response");
             controller.readData();
        //    Get.offNamed(AppRoute.ordersViewBydriverid);
        
              Get.back();
              //update();


            Get.rawSnackbar(
              titleText: const Text("Success", style: TextStyle(color: Colors.white)),
              messageText: const Text("Order Updated Successfully", style: TextStyle(color: Colors.white)),
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
  
}


//**************************************START FOR BOTTELS CALCULATIONS*********************************** */

//   void resetBottelPerPrice() {
// //      if(pricePerBottel.text.isEmpty || bottelsId.text.isEmpty)
// //  {
// // pricePerBottel.text = "0";
// //  }else{
// //   pricePerBottel.text = pricePerBottel.text;
// //  }
// pricePerBottel.text = "0";

// }
  void resetTotalPriceANDQTYOFBottels() {

 if(qtyOfBottles.text.isEmpty && totalPriceBottel.text.isEmpty && bottelsId.text.isEmpty)
 {
    qtyOfBottles.text = "0";
    totalPriceBottel.text = "0";
 }else{
  qtyOfBottles.text = qtyOfBottles.text;
  totalPriceBottel.text = totalPriceBottel.text;
 }

}



  onBottlesChanged(String? bottelsId) async {

  if (bottelsId != null && bottelsId.isNotEmpty) {

    resetTotalPriceANDQTYOFBottels();
    getPricePerBottelData();
    getTotalPriceOfBottelData();
    getTotalPriceOrder();
    getDebtValue();


    update();
  }
}



Future getPricePerBottelData() async {
  update();
    List<Map> response = await sqlDb.readData('''
      SELECT * FROM bottels
         
         WHERE bottels.id = ${bottelsId.text} 
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
      SELECT * FROM bottels
                 
         WHERE bottels.id = ${bottelsId.text}
      ''');

  if (response.length>0) {
    bottels.clear();

    List listbottels = response;
    bottels.addAll(listbottels.map((e) => BottelsModel.fromJson(e)));
  
       
         for(int i = 0; i < bottels.length ; i++)
         {

      //  totalPriceBottel.text = (int.parse(qtyOfBottles.text) * double.parse(pricePerBottel.text)).toString();
      //       print("yesssss has bottels totalPriceBottel");

      if (qtyOfBottles.text != null && qtyOfBottles.text.isNotEmpty) {
  int quantity = int.parse(qtyOfBottles.text);
  if (quantity != null) {
    double price = double.parse(pricePerBottel.text);
    if (price != null) {
      totalPriceBottel.text = (quantity * price).toStringAsFixed(2);
    } 
  } 
} 

//  }




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



  Future getJarsData() async {
    jar.clear();
    update();
    statusRequest =StatusRequest.loading;
     

    List<Map> response = await sqlDb.readData("SELECT * FROM jars");
       

      print("***************##############************* Controler $response ");
    
     statusRequest = handlingData(response); 


     if(StatusRequest.success == statusRequest)
     {
       
            if(response.length > 0)

       {
            List listJars = response;
    jar.addAll(listJars.map((e) => JarModels.fromJson(e)));
     update();
  print("yes has jars data");
    return response;
    
        
       }else{
        print("No data for jars");
        update();
    return  statusRequest = StatusRequest.failure;
  

     }
     
     }
     print("=======nos datas");
  update();

   
  }








  void resetTotalPriceANDQTYSOFJARS() {

 if(jarIn.text.isEmpty && jarOut.text.isEmpty && qtyPreviousOFJars.text.isEmpty)

 {
    jarIn.text = "0";
    jarOut.text = "0";
    qtyPreviousOFJars.text = "0";

   // totalPriceJars.text = "0";
    
 }else{

      jarIn.text = jarIn.text;
      jarOut.text = jarOut.text;
      qtyPreviousOFJars.text = qtyPreviousOFJars.text ;

    //  totalPriceJars.text =totalPriceJars.text;
     }

    
  }




//   void resetJarPerPrice() {
// pricePerJar.text = "0";

// }



    // Add this function to update the price based on the selected bottle
    onBottlesFORJARChanged(String jarid) async {

    if (jarid != null && jarid.isNotEmpty) {

      
    //  resetBottelPerPrice();
      resetTotalPriceANDQTYSOFJARS();
      getPricePerJarData();
      
      getTotalQTYOFJARSSData();
      getTotalPriceOfJARData();
      getTotalPriceOrder();
       getDebtValue();
     
    // getJarsData();
       update(); // Update the UI
      
     }
  }




    Future getPricePerJarData() async {
  update();
    List<Map> response = await sqlDb.readData('''
      SELECT * FROM jars
      
         
      ''');
      // WHERE bottels.id = ${bottelsId.text} 

  if (response.isNotEmpty) {
    jar.clear();

    List listJars = response;
    jar.addAll(listJars.map((e) => JarModels.fromJson(e)));
  
       
         for(int i = 0; i < jar.length ; i++)
         {
           jarsId.text =jar[i].id.toString();

          pricePerJar.text =jar[i].price.toString();

             print("the JarId.text is = ${jarsId.text}");

            print("the pricePerJar.text is = ${pricePerJar.text}");

         }
     
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
      SELECT * FROM jars
        
      ''');

      // WHERE bottels.id = ${bottelsId.text}

  if (response.isNotEmpty) {
    jar.clear();

    List listJars = response;
    jar.addAll(listJars.map((e) => JarModels.fromJson(e)));
  
       
         for(int i = 0; i < jar.length ; i++)
         {
          jarsId.text =jar[i].id.toString();
          jarsName.text = jar[i].name.toString();

    //  totalPriceJars.text = (int.parse(jarIn.text) * double.parse(pricePerJar.text)).toString();
    //         print("yesssss has jars totalPriceJar");


      if (jarIn.text.isNotEmpty && pricePerJar.text.isNotEmpty) {
      
      int jrIns_ = int.parse(jarIn.text);

     double pricePerJarS_ = double.parse(pricePerJar.text);

     totalPriceJars.text = (jrIns_ * pricePerJarS_).toStringAsFixed(2);
  


     print("the totalPriceJars.text is = ${totalPriceJars.text}");
 
         } 

         }
      update();
      }else{
        print("noooo hasn't totalPriceJar");
        totalPriceJars.text ="044";
      }
    

update();
     return response;

  }




   Future getTotalQTYOFJARSSData() async {
    update();
    List<Map> response = await sqlDb.readData('''
      SELECT * FROM jars

      ''');
      
        //  WHERE bottels.id = ${bottelsId.text}

  if (response.length>0) {
    jar.clear();

    List listJars = response;
    jar.addAll(listJars.map((e) => JarModels.fromJson(e)));
  
       
         for(int i = 0; i < jar.length ; i++)
         {
        //  pricePerBottel.text =jar[i].price.toString();

    //  totalJars.text = (int.parse(jarIn.text) + int.parse(qtyPreviousOFJars.text)- int.parse(jarOut.text)).toString();
    //         print("yesssss has jars totalJars");

  if (jarIn.text.isNotEmpty && jarOut.text.isNotEmpty && qtyPreviousOFJars.text.isNotEmpty) {
     
      int jrIns = int.parse(jarIn.text);

      int jrOuts = int.parse(jarOut.text);

      int prevJars = int.parse(qtyPreviousOFJars.text);

      totalJars.text = (jrIns - jrOuts + prevJars).toString();

          }

         }
      update();
      }
      else{
        print("noooo hasn't jars totalJars");
        totalPriceJars.text ="0";
      }
    

update();
     return response;

  } 





     Future getTotalPriceOrder() async {
    update();
    List<Map> response = await sqlDb.readData('''
      SELECT 
      jars.id, jars.name, jars.price,
      bottels.id, bottels.name, bottels.price


       FROM jars, bottels
      
         
      ''');
        //  WHERE bottels.id = ${bottelsId.text} 
        //  WHERE bottels.id = "${bottelsId.text}" AND jars.id = "${jarsId.text}"

  if (response.length>0) {
    jar.clear();

    List listJars = response;
    jar.addAll(listJars.map((e) => JarModels.fromJson(e)));
  
       
        //  for(int i = 0; i < listJars.length ; i++)
        //  {
        //  pricePerBottel.text =bottels[i].price.toString();

    //  totalPrice.text = (double.parse(totalPriceBottel.text) + double.parse(totalPriceJars.text)).toString();
    //         print("yesssss has jars totalJars");
if (totalPriceBottel.text.isNotEmpty && totalPriceJars.text.isNotEmpty && newDebt.text.isNotEmpty) {
    double totalPriceBottels_ = double.parse(totalPriceBottel.text);
    double totalPriceJars_ = double.parse(totalPriceJars.text);
    double newDebt_ = double.parse(newDebt.text);

    totalPrice.text = (totalPriceBottels_ + totalPriceJars_ + newDebt_).toStringAsFixed(2);
    print("the totalPrice.text is = ${totalPrice.text}");
    update();

} else if (totalPriceJars.text.isNotEmpty &&  newDebt.text.isNotEmpty) {
    double totalPriceJars_ = double.parse(totalPriceJars.text);
    double newDebt_ = double.parse(newDebt.text);

    totalPrice.text = (totalPriceJars_ + newDebt_).toStringAsFixed(2);
     print("the totalPrice.text is = ${totalPrice.text}");
    update();

} else if (totalPriceBottel.text.isNotEmpty && newDebt.text.isNotEmpty) {
    double totalPriceBottels_ = double.parse(totalPriceBottel.text);
    double newDebt_ = double.parse(newDebt.text);

    totalPrice.text = (totalPriceBottels_ + newDebt_).toStringAsFixed(2);
     print("the totalPrice.text is = ${totalPrice.text}");
    update();
}
      // update();
      }else{
        print("noooo Total Price");
        totalPrice.text ="0";
      }
    

    update();
     return response;

  } 
//**************************************End FOR JARS CALCULATIONS************************************** */



 Future getDebtValue() async{
 //debt.text = "78";

    update();
    List<Map> response = await sqlDb.readData('''
     SELECT 
     orders.id, orders.jar_id, orders.bottle_id, orders.paid, orders.total_price,
      jars.id,
      bottels.id

       FROM orders, jars, bottels
      
         
      ''');
      
 if (response.isNotEmpty) {

    orders.clear();

    List listOrders = response;
    orders.addAll(listOrders.map((e) => OrdersModel.fromJson(e)));

    

    if (totalPrice.text.isNotEmpty && paid.text.isNotEmpty) {

       double totalPrice_ = double.parse(totalPrice.text);
       double paid_= double.parse(paid.text);

       oldDebt.text = (totalPrice_ - paid_).toStringAsFixed(2);
       print("the debt is = ${oldDebt.text}");
       update();

        } 
        // else if(totalPrice.text.isNotEmpty) {

        //   double totalPrice_ = double.parse(totalPrice.text);
        //   debt.text = (totalPrice_ - totalPrice_).toString();

        // }
        // else if(paid.text.isNotEmpty) {
           
        //   double paid_= double.parse(paid.text);
        //   debt.text = (paid_ - paid_).toString();

        // }


 }else{
   print("noooo hasnt debt");
        // debt.text ="0";

 }
 update();
 return response;
 }


 






  // removeData() async {
  

  //       int response = await sqlDb.deleteData
  //                ('''
  //                   DELETE * FROM orders 
                   
  //               ''');
  //            if(response > 0) {

             
             
  //           //  update();


  //          //   print("========***** DELETED $response + $id_");
  //          //    readData();
              
              
  //             Get.snackbar("success", "Data Deleted", backgroundColor: Colors.red,colorText: Colors.white);
           
  //             return response; 
            
  //            }else{
            

  //            } 
  
  // //  update();
  // //    return  statusRequest = StatusRequest.failure;

            
             
  //  }
  


  logout()
  {
    
       // String userid = myservices.sharedPreferences.getString("id").toString();

//     FirebaseMessaging.instance.unsubscribeFromTopic("users"); // لكل المستخدمين
//     FirebaseMessaging.instance.unsubscribeFromTopic("users${userid}"); // خاص Topic إلو  user  كل // firebase topic for specific user
// print("{Logoout User id is : $userid}");

   myservices.sharedPreferences.clear(); // null 
   Get.offAllNamed(AppRoute.driverLogin);
  }



  @override
  void onInit() {
   ordersModel = Get.arguments['ordersModel_'];

  //  getCustomersData();
  
   getBottelsData();
    getJarsData();




    qtyOfBottles= TextEditingController();
    pricePerBottel = TextEditingController();
    totalPriceBottel = TextEditingController();


    jarIn= TextEditingController();
    jarOut = TextEditingController();
     qtyPreviousOFJars = TextEditingController();
    //qtyPreviousOFJars.text.isNotEmpty ?  TextEditingController() : '0';

     totalJars= TextEditingController();
    // totalJars.text.isNotEmpty ? TextEditingController() : '0';

    pricePerJar= TextEditingController();
    totalPriceJars = TextEditingController();


    townId = TextEditingController(); 
    townName = TextEditingController();

    districtId = TextEditingController(); 
    districtName = TextEditingController();

    customerName = TextEditingController(); 
    customerId = TextEditingController();


    // dropdownCustomersName = TextEditingController();
    // dropdownCustomersId = TextEditingController();



    jarsName= TextEditingController();
    jarsId= TextEditingController();

    dropdownBottelsName = TextEditingController();
    dropdownBottelsId = TextEditingController();

    bottelsName= TextEditingController();
    bottelsId= TextEditingController();

    oldDebt= TextEditingController();
    newDebt= TextEditingController();

    paid= TextEditingController();

    totalPrice = TextEditingController();



     // get data from db view to texts in edit
    id = ordersModel!.id.toString();

    dayId.text =  ordersModel!.dayId.toString();
    dayName.text =  ordersModel!.dayName.toString();

    customerId.text =  ordersModel!.customerId.toString();
    customerName.text =  ordersModel!.customerName.toString();


    townId.text =  ordersModel!.townId.toString();
    townName.text =  ordersModel!.townName.toString();

    districtId.text =  ordersModel!.districtId.toString();
    districtName.text =  ordersModel!.districtName.toString();

    // bottelsId.text =  ordersModel!.bottelId.toString();
    // bottelsName.text =  ordersModel!.bottelName.toString();

    // pricePerBottel.text =  ordersModel!.pricePerBottel.toString();
    // qtyOfBottles.text =  ordersModel!.qtyOfBottels.toString();
    // totalPriceBottel.text =  ordersModel!.totalpriceOfBottels.toString();

    // jarsId.text =  ordersModel!.jarId.toString();
    // jarsName.text =  ordersModel!.jarName.toString();


    // jarIn.text =  ordersModel!.qtyJarIn.toString();
    // jarOut.text =  ordersModel!.qtyJarOut.toString();
       

       
       qtyPreviousOFJars.text = ordersModel!.totalJar.toString();
 
       print("prev Jars Text: ${qtyPreviousOFJars.text}");
   

    
        totalJars.text =  ordersModel!.totalJar.toString();
 
         print("Total Jars Text: ${totalJars.text}");
   

  


 //   qtyJarIn = json['qty_jar_in'] != null ? int.tryParse(json['qty_jar_in'].toString()) : null;

    // pricePerJar.text =  ordersModel!.pricePerJar.toString();
    // totalPriceJars.text =  ordersModel!.totalpriceOfJars.toString();

    // paid.text =  ordersModel!.paid.toString();
    newDebt.text =  ordersModel!.oldDebt.toString();
  //  newDebt.text =  ordersModel!.newDebt.toString();


    // totalPrice.text =  ordersModel!.totalPrice.toString();



    super.onInit();
  }

   @override
  void dispose() {
    qtyOfBottles.dispose();
    pricePerBottel.dispose();
    totalPriceBottel.dispose();


    jarIn.dispose();
    jarOut.dispose();



    qtyPreviousOFJars.dispose();
totalJars.dispose();
pricePerJar.dispose();
    totalPriceJars.dispose();





    townId.dispose();
    townName.dispose();

    districtId.dispose();
    districtName.dispose();

    customerName.dispose();
    customerId.dispose();


jarsName.dispose();
    jarsId.dispose();

    dropdownBottelsName.dispose();
    dropdownBottelsId.dispose();

    bottelsName.dispose();
    bottelsId.dispose();

    oldDebt.dispose();
    newDebt.dispose();
    paid.dispose();



    totalPrice.dispose();





    super.dispose();
  }

}