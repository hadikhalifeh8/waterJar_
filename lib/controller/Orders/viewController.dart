import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/districtsModel.dart';
import 'package:water_jar/data/model/ordersModel.dart';

class ViewOrdersController extends GetxController {

  SqlDb sqlDb = SqlDb();
  List<OrdersModel> orders = [];
  StatusRequest statusRequest = StatusRequest.none;

 OrdersModel? ordersModel;
String? id;






  Future readData() async{
    orders.clear(); // for delete refresh
     update();
    statusRequest = StatusRequest.loading;
   

    // List<Map> response = await sqlDb.readData("SELECT * FROM district WHERE id = ");
    List<Map> response = await sqlDb.readData(''' SELECT * FROM orders

   
    
   



        ''');

  //  orders.id, orders.day_id, orders.driver_id, 
  //  orders.customer_id, orders.town_id, orders.district_id, orders.jar_id, orders.bottle_id,
  //  orders.qty_of_bottles, orders.price_per_bottel, orders.tolal_price_bottel,
  //  orders.qty_jar_in, orders.qty_jar_out,  orders.qty_previous_jars, orders.total_jar,
  //  orders.price_per_jar, orders.total_price_jars, orders.debt, orders.paid, orders.total_price,
   

  //  days.id as day_id, days.name as day_name,
  //  drivers.id as driver_id, drivers.name as driver_name,
  //  customers.id as customer_id, customers.name as customer_name,
  //  towns.id as town_id, towns.name as town_name,
  //  district.id as district_id, district.name as district_name,
  //  jars.id as jar_id, jars.name as jar_name,
  //  bottels.id as bottle_id, bottels.name as bottle_name



  // FROM orders
  // JOIN days ON orders.day_id = days.id
  // JOIN drivers ON orders.driver_id = drivers.id
  // JOIN customers ON orders.customer_id = customers.id
  // JOIN towns ON orders.town_id = towns.id
  // JOIN district ON orders.district_id = district.id
  // JOIN jars ON orders.jar_id = jars.id
  // JOIN bottels ON orders.bottle_id = bottels.id;
      print("***************##############************* Controler $response ");


           statusRequest = handlingData(response);
           if(StatusRequest.success == statusRequest)
           {
             if(response.isNotEmpty)
             {
                    List listOrders  = response;
            
            orders.addAll(listOrders.map((e) => OrdersModel.fromJson(e)));
                     
                     update();
                     Get.toNamed(AppRoute.ordersViewBydriverid);

                      print("yes has data");
                        return response;
             }else{
               print("No data");
               update();
   
    return  statusRequest = StatusRequest.failure;

             }
            
           }
           update();
            

  }



  
  // removeData() async {
  

  //       int response = await sqlDb.deleteData
  //                ('''
  //                   DELETE  FROM orders 
                   
  //               ''');
  //            if(response > 0) {

             
             
  //           //  update();


  //          //   print("========***** DELETED $response + $id_");
  //            //  readData();
              
              
  //             Get.snackbar("success", "Data Deleted", backgroundColor: Colors.red,colorText: Colors.white);
           
  //             return response; 
            
  //            }else{
            

  //            } 
  
  // //  update();
  // //    return  statusRequest = StatusRequest.failure;

            
             
  // }




     goToaddPage()
  {
    Get.toNamed(AppRoute.districtadd);
  }





  //   goToEditPage(DistrictsModel districtsModel)
  // {
  //   Get.toNamed(AppRoute.districtedit, 
  //                          arguments: {

  //                          "districtsModel_" :districtsModel, 


  // });
  // }


   
   @override
  void onInit() {
  //  readData();
    // removeData();
    super.onInit();
  }


}