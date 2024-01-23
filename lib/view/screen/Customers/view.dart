import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Customers/viewController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/constant/routes.dart';
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
                centerTitle: true,
                leading: IconButton(onPressed: (){Get.offAllNamed(AppRoute.home);}, icon: const Icon(Icons.arrow_back)),

                
                ),

                
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
                            onDelete: (){ controller.removeData(controller.customers[index].id.toString());} ,
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