import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Jars/viewCompany.dart';


import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/view/widget/Jars/CustomListTileJars.dart';


class ViewJars extends StatelessWidget {
  const ViewJars({super.key});

  @override
  Widget build(BuildContext context) {
    ViewJarsController controller = Get.put(ViewJarsController());
    return Scaffold(
      appBar: AppBar(
               title: const Text("Jars"),
               centerTitle: true,
                leading: IconButton(onPressed: (){Get.offAllNamed(AppRoute.home);}, icon: const Icon(Icons.arrow_back)),

      ),

      body: 
       
       
            GetBuilder<ViewJarsController>(builder: (controller) =>
            
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
                                                      
                                                      itemCount: controller.jar.length,
                                                      itemBuilder: (context, index) =>
                        CustomListTileJars(
                                    
                                    jarName: controller.jar[index].name.toString(), 
                                    price: controller.jar[index].price.toString(), 

                                    
                                  
                                    leading_: controller.jar[index].id.toString(),




                                    onEdit: (){controller.goToEditPage(controller.jar[index]);},
          


                                      iconDelete: Icons.delete_forever, 
                                       onDelete: () { 
                                        controller.deleteData(controller.jar[index].id.toString());
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