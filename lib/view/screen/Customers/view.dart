// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:water_jar/controller/Customers/viewController.dart';
// import 'package:water_jar/core/class/handlingDataView.dart';
// import 'package:water_jar/view/widget/Customers/CustomListTileCustomer.dart';


// class ViewCustomer extends StatelessWidget {
//   const ViewCustomer({super.key});

//   @override
//   Widget build(BuildContext context) {
 
//     ViewCustomerController controller = Get.put(ViewCustomerController());

//     return Scaffold(

//       appBar: AppBar(
//                 title: const Text("View All Customer"),
//                 centerTitle: true,),

                
//                  body: 

//                      GetBuilder<ViewCustomerController>(builder: (controller) => 
//                         HandlingDataView(
//                       statusRequest: controller.statusRequest,
                     
//                       widget: 
                     
//                    ListView(
//                     children: [
//                         // Stack(
//                         //       alignment: Alignment.center,
//                         //       clipBehavior: Clip.none,
                         
                         
//                         //   children: [
                             
                              
//                                 ListView.builder(
                                            
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
                                            
                                
//                                 itemCount: controller.customers.length,
//                                 itemBuilder: (context, index) =>
                                            
//                       CustomListTileCustomers(
                            
//                             town_: controller.customers[index].townName.toString(), 
//                             district_: controller.customers[index].districtName.toString(),
//                             leading_: controller.customers[index].name.toString(),
//                             onEdit:(){ controller.goToEditPage(controller.customers[index]);},
//                             onDelete:(){ controller.goToEditPage(controller.customers[index]);} , 
//                             iconDelete: Icons.delete_forever_sharp,
//                             ), 

//                         //  CustomListTileCustomers(
                            
//                         //     town_: "town", 
//                         //     district_: "district_",
//                         //     leading_: "leading",
//                         //   //  onEdit:(){ }  , 
//                         //    // iconDelete: Icons.delete_forever_sharp,
//                         //     ), 

                       
                              
                              
//                               )
                                         
                                               
//                    // ])
//                           ],
//                         ),
                        
                 
                     
//                      ),
                 
             
//     ), 
//        floatingActionButton: FloatingActionButton(onPressed: (){
//                                   controller.goToaddPage();
//                 },
//                 child: Icon(Icons.add)),

         

         
        
    
//     );

    
//   }
// }

// //https://doripot.com/how-to-show-data-from-sqflite-a-dropdown-in-a-flutter/



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Customers/viewController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/view/widget/Customers/CustomListTileCustomer.dart';
import 'package:water_jar/view/widget/Drivers/CustomListTileDrivers.dart';

class ViewCustomers extends StatelessWidget {
  const ViewCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    ViewCustomerController controller = Get.put(ViewCustomerController());

    return Scaffold(

      appBar: AppBar(
                title: const Text("Customers"),
                centerTitle: true,),

                
                 body: 

                     GetBuilder<ViewCustomerController>(builder: (controller) => 
                        HandlingDataView(
                      statusRequest: controller.statusRequest,
                     
                      widget: 
                     
                   ListView(
                    children: [
                        Stack(
                          children: [
                            
                           
                             
                              
                                ListView.builder(
                                            
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                            
                                
                                itemCount: controller.customers.length,
                                itemBuilder: (context, index) =>
                                            
                      CustomListTileCustomers(
                            
                            leading_: controller.customers[index].name.toString(), 
                            town_: controller.customers[index].townName.toString(),
                            district_: controller.customers[index].districtName.toString(),
                            onEdit:(){controller.goToEditPage(controller.customers[index]);}  , 
                            onDelete: (){ controller.goToEditPage(controller.customers[index]);} ,
                           // iconEdit: Icons.edit, 
                            iconDelete: Icons.delete_forever_sharp
                            ), 

                       
                              
                              
                              )
                                         
                                               
                    ])
                          ],
                        ),
                        
                 
                     
                     ),
                 
             
    ), 
       floatingActionButton: FloatingActionButton(onPressed: (){
                                  controller.goToaddPage();
                },
                child: Icon(Icons.add)),

         

         
            //  bottomNavigationBar: Container( color: Colors.green.shade300,
            //  child:   MaterialButton(onPressed: () async{
            //             await  controller.sqlDb.myDeleteDataBase();
                      
            //             }, 
            //             child: Text("Delete My DataBase"),
            //             ),),
    
    );

    
  }
}

//https://doripot.com/how-to-show-data-from-sqflite-a-dropdown-in-a-flutter/