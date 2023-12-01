import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Drivers/viewController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/view/widget/Drivers/CustomListTileDrivers.dart';

class ViewDrivers extends StatelessWidget {
  const ViewDrivers({super.key});

  @override
  Widget build(BuildContext context) {
    ViewDriversController controller = Get.put(ViewDriversController());

    return Scaffold(

      appBar: AppBar(
                title: const Text("Drivers"),
                centerTitle: true,),

                
                 body: 

                     GetBuilder<ViewDriversController>(builder: (controller) => 
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
                                            
                                
                                itemCount: controller.driver.length,
                                itemBuilder: (context, index) =>
                                            
                      CustomListTileDrivers(
                            
                            title_: controller.driver[index].name.toString(), 
                            leading_: controller.driver[index].phone.toString(),
                            onEdit:(){controller.goToEditPage(controller.driver[index]);}  , 
                            onDelete: (){{controller.removeData(controller.driver[index].id);} } ,
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

         

         
             bottomNavigationBar: Container( color: Colors.green.shade300,
             child:   MaterialButton(onPressed: () async{
                        await  controller.sqlDb.myDeleteDataBase();
                      
                        }, 
                        child: Text("Delete My DataBase"),
                        ),),
    
    );

    
  }
}

//https://doripot.com/how-to-show-data-from-sqflite-a-dropdown-in-a-flutter/