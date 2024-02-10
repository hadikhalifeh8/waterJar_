import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Bottels/viewController.dart';
import 'package:water_jar/controller/Jars/viewCompany.dart';


import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/view/widget/Bottels/CustomListTileBottels.dart';
import 'package:water_jar/view/widget/Jars/CustomListTileJars.dart';



class ViewBottels extends StatelessWidget {
  const ViewBottels({super.key});

  @override
  Widget build(BuildContext context) {
    ViewBottelsController controller = Get.put(ViewBottelsController());
    return Scaffold(
      appBar: AppBar(
               title: const Text("Bottels"),
               centerTitle: true,
                leading: IconButton(onPressed: (){Get.offAllNamed(AppRoute.home);}, icon: const Icon(Icons.arrow_back)),

      ),

      body: 
       
       
            GetBuilder<ViewBottelsController>(builder: (controller) =>
            
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
                                                      
                                                      itemCount: controller.bottels.length,
                                                      itemBuilder: (context, index) =>
                        CustomListTileBottels(
                                   
                                   
                                    leading_: controller.bottels[index].id.toString(),
                                    name_: controller.bottels[index].name.toString(),                              
                                    // company_: controller.bottels[index].companyName.toString(),
                                    price_: controller.bottels[index].price!.toStringAsFixed(2),





                                    onEdit: (){
                                      controller.goToEditPage(controller.bottels[index]);},
          


                                      iconDelete: Icons.delete_forever, 
                                       onDelete: () { 
                                        controller.removeData(controller.bottels[index].id.toString());
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