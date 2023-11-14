import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Districts/viewController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/view/widget/Districts/CustomListTile.dart';


class ViewDistreicts extends StatelessWidget {
  
  const ViewDistreicts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    
   ViewDistreictsController controller = Get.put(ViewDistreictsController());
 

    return Scaffold(
      appBar: AppBar(
        title: const Text("View All Districts"),
        centerTitle: true,
      ),
      body:   

         // CustomTitlesOFNames(),


        GetBuilder<ViewDistreictsController>(builder: (controller) => 


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

          itemCount: controller.district.length,
          itemBuilder: (context, index) => 
            CustomListTile(
            
            id: controller.district[index].id.toString(),
             districtName: controller.district[index].name.toString(), 
             townName: controller.district[index].townName.toString(), 
           iconDataEdit: Icons.edit, 
           iconDataDelete: Icons.delete_forever_rounded,
           
            onEdit: () { controller.goToEditPage(controller.district[index]); }, 

            onDelete: () {  controller.removeData(controller.district[index].id.toString());},
            
            ), 
         ),
           ])
                          
              ]),
                       
                       )
        
        
        
        
        ),
            
          
      
      

        floatingActionButton: FloatingActionButton(onPressed: (){
                                   controller.goToaddPage();
                },
                child: Icon(Icons.add)),
         
    );
  }
}