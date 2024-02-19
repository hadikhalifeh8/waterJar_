import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/core/services/services.dart';
import 'package:water_jar/data/model/districtsModel.dart';
import 'package:water_jar/data/model/ordersModel.dart';

class ViewOrdersController extends GetxController {

  SqlDb sqlDb = SqlDb();
  Myservices myservices = Get.find();


List<OrdersModel> orders = [];
 OrdersModel? ordersModel;


StatusRequest statusRequest = StatusRequest.none;


bool isSearch = false;
TextEditingController search = TextEditingController();
//String searchText ="";
FocusNode focusNode = FocusNode();



//search بس يضغط على زر ال 
onSearchFunc() {
  isSearch = !isSearch;
  search.clear();
  readData();
  print("isSearch = $isSearch");

  update();
}



onSearchChanged(String value) {
  search.text = value.toLowerCase(); // Ensure consistency in case
  print("Search text: ${search.text}");

  if (search.text.isEmpty) {
    // If search text is empty, reset the list to its original state
    orders.clear();
    readData(); // Assuming originalOrders contains the full list
  } else {
    // Perform filtering based on the search text
    myFilterOrders();
  }
  update();
}


myFilterOrders() {
  if (search.text.isEmpty) {
    // If search text is empty, show all orders
    orders = List.from(orders);
  } else {
    List<OrdersModel> filteredOrders = orders
        .where((order) =>
            order.customerName!
                .toString()
                .toLowerCase()
                .contains(search.text.toLowerCase()))
        .toList();

    if (filteredOrders.isEmpty && isSearch) {
      update();
      // If no matching orders found, show all orders
     orders.clear();
    print("nooooo data+++++++++++++++++");

    // return  statusRequest = StatusRequest.failure;
  

     readData();
    } else {
      orders = filteredOrders;
    }
    //update();
   // orders.clear();
    orders = List.from(filteredOrders);
    
    print("yess has  data +++++++++++++++++");

  }
  update();
}




  Future readData() async{
    orders.clear(); // for delete refresh
     update();
    statusRequest = StatusRequest.loading;
   

    // List<Map> response = await sqlDb.readData("SELECT * FROM district WHERE id = ");
    List<Map> response = await sqlDb.readData(''' 
    SELECT 
          orders.id,
          orders.customer_id ,
          orders.day_id,
          orders.driver_id,
          orders.town_id,
          orders.district_id,
          orders.jar_id,
          orders.bottle_id,
          orders.qty_of_bottles,
          orders.price_per_bottel,
          orders.tolal_price_bottel,
          orders.qty_jar_in,
          orders.qty_jar_out,
          orders.qty_previous_jars,
                   
          orders.total_jar,
          orders.price_per_jar,
          orders.total_price_jars,
          orders.old_debt,
          orders.new_debt,
          orders.paid,
          orders.total_price,

   
   days.id as day_id, days.name as day_name,
   drivers.id as driver_id, drivers.name as driver_name,
   customers.id as customer_id, customers.name as customer_name,
   towns.id as town_id, towns.name as town_name,
   district.id as district_id, district.name as district_name


   

  FROM orders

  JOIN days ON orders.day_id = days.id
  JOIN drivers ON orders.driver_id = drivers.id
  JOIN customers ON orders.customer_id = customers.id
  JOIN towns ON orders.town_id = towns.id
  JOIN district ON orders.district_id = district.id



 


  

   WHERE orders.driver_id = "${myservices.sharedPreferences.getString("id").toString()}"
        ''');


      print("***************##############************* Controler $response ");


           statusRequest = handlingData(response);
           if(StatusRequest.success == statusRequest)
           {
             if(response.isNotEmpty)
             {
                    List listOrders  = response;
            
            orders.addAll(listOrders.map((e) => OrdersModel.fromJson(e)));
                      
                     
                   update();   
                   Get.toNamed(AppRoute.ordersViewBydriverid).toString();
                   search.clear();
                isSearch;
                  
 
                      print("yes has data  =====90");
                        return response;
             }else{
               print("No data =====90");
               update();  
   Get.toNamed(AppRoute.ordersViewBydriverid);
    return  statusRequest = StatusRequest.failure;
    

             }
            
           }
            print("=======nos datas");
           update();
            

  }

  

    logout()
  {
   myservices.sharedPreferences.clear(); // null 
   Get.offAllNamed(AppRoute.driverLogin);
  }



   goToEditOrderPage(OrdersModel ordersModel)
  {
    Get.toNamed(AppRoute.orderedit,
          
             arguments: {
              'ordersModel_' : ordersModel
    });
           
  }




 @override
  void onClose() {
    // Reset isSearch to false when the controller is closed
    isSearch = false;
    super.onClose();
  }


   
   @override
  void onInit() {

    // readData();
    // removeData();
    
    super.onInit();
  }





}