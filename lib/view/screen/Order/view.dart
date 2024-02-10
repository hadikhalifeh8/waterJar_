import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Districts/viewController.dart';
import 'package:water_jar/controller/Orders/viewController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/view/widget/Orders/CustomListTileOrder.dart';


class ViewOrdersByDrivers extends StatelessWidget {
  
  const ViewOrdersByDrivers({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    
   ViewOrdersController controller = Get.put(ViewOrdersController());
 

    return Scaffold(
      appBar: AppBar(
        title: const Text("View All Orders"),
        centerTitle: true,
      //   leading: IconButton(onPressed: (){Get.offAllNamed(AppRoute.home);}, icon: const Icon(Icons.arrow_back)),

      ),
      body:   

         // CustomTitlesOFNames(),


        GetBuilder<ViewOrdersController>(builder: (controller) => 


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

          itemCount: controller.orders.length,
          itemBuilder: (context, index) => 
            CustomListTileOrder(
            
            id: controller.orders[index].id.toString(),
             districtName: controller.orders[index].customerName.toString(), 
             townName: controller.orders[index].totalPrice.toString(), 
          // iconDataEdit: Icons.edit, 
           iconDataDelete: Icons.delete_forever_rounded,
           
          //  onEdit: () { controller.goToEditPage(controller.district[index]); }, 

          //  onDelete: () {  controller.removeData(controller.orders[index].id.toString());},
            
            ), 
         ),
           ])
                          
              ]),
                       
                       )
        
        
        
        
        ),
            
          
      
      

        // floatingActionButton: FloatingActionButton(onPressed: (){
        //                            controller.goToaddPage();
        //         },
        //         child: Icon(Icons.add)),
         
    );
  }
}