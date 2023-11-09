import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Drivers/viewController.dart';
import 'package:water_jar/controller/Towns/viewController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/view/widget/Drivers/CustomListTileDrivers.dart';
import 'package:water_jar/view/widget/Town/CustomListTileTown.dart';

class ViewTowns extends StatelessWidget {
  const ViewTowns({super.key});

  @override
  Widget build(BuildContext context) {
    ViewTownsController controller = Get.put(ViewTownsController());
    return Scaffold(
      appBar: AppBar(
               title: const Text("View All Towns"),
               centerTitle: true,
      ),

      body: 
       
       
            GetBuilder<ViewTownsController>(builder: (controller) =>
            
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
                                                      
                                                      itemCount: controller.towns.length,
                                                      itemBuilder: (context, index) =>
                                                            CustomListTileTown(
                                    
                                    title_: controller.towns[index].name.toString(), 
                                  
                                    leading_: controller.towns[index].id.toString(),
          
                                      iconDelete: Icons.delete_forever, 
                                       onDelete: () { 
                                        controller.deleteData(controller.towns[index].id.toString());
                                        },
                                          ),
                                        
                                              
                                              
                                              
                                               
                                                  ),
                                                ],
                                  ),
                                ],
                              ),
                            
                          )), 

              
              

              
                     
    

          
floatingActionButton: FloatingActionButton(onPressed: (){
                                  controller.goToaddPage();
                },
                child: Icon(Icons.add)),



    );
  }
}