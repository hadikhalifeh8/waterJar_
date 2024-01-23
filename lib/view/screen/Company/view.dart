import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Company/viewCompany.dart';

import 'package:water_jar/controller/Towns/viewController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/view/widget/Company/CustomListTileCompany.dart';

import 'package:water_jar/view/widget/Town/CustomListTileTown.dart';

class ViewCompanies extends StatelessWidget {
  const ViewCompanies({super.key});

  @override
  Widget build(BuildContext context) {
    ViewCompaniesController controller = Get.put(ViewCompaniesController());
    return Scaffold(
      appBar: AppBar(
               title: const Text("Companies"),
               centerTitle: true,
                leading: IconButton(onPressed: (){Get.offAllNamed(AppRoute.home);}, icon: const Icon(Icons.arrow_back)),

      ),

      body: 
       
       
            GetBuilder<ViewCompaniesController>(builder: (controller) =>
            
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
                                                      
                                                      itemCount: controller.company.length,
                                                      itemBuilder: (context, index) =>
                        CustomListTileCompany(
                                    
                                    companyName: controller.company[index].name.toString(), 
                                  
                                    leading_: controller.company[index].id.toString(),




                                    onEdit: (){controller.goToEditPage(controller.company[index]);},
          


                                      iconDelete: Icons.delete_forever, 
                                       onDelete: () { 
                                        controller.deleteData(controller.company[index].id.toString());
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