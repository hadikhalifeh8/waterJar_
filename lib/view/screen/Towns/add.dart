import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Drivers/addController.dart';
import 'package:water_jar/controller/Towns/addController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/functions/validationinput.dart';
import 'package:water_jar/view/widget/Drivers/CustomButton.dart';

import 'package:water_jar/view/widget/Town/CustomTextFormTown.dart';

class AddTown  extends StatelessWidget {
  const AddTown ({super.key});

  @override
  Widget build(BuildContext context) {
     Get.lazyPut(() =>AddTownController());
    return Scaffold(appBar: AppBar(

      title: const Text("Add Town"),
      centerTitle: true,
    ),

    body:
          GetBuilder<AddTownController>(builder: (controller)
          =>


             //    if(controller != null) {
          HandlingDataRequest(
            
            statusRequest: controller.statusRequest,
            
            
             widget:  Form(
      key: controller.formState,
       child: ListView(children: [
     
    CustomTextFormTown(
                                 label_: "town", 
                                 hintText_: "Enter Town Name", 
                                 validation: (val){
                                  return valiInput(val!, 4, 20, "name");
                                 }, 
                                 mycontroller: controller.name,
                                 icon_: Icons.location_city_rounded, 
                                 isNumber: false, 
                                 
                                 //onTap_: () { }, 
                                 ),
     
     

     
     
     
       
     
     
     
     CustomButton(
                  onPressed_: (){
                    controller.insertData();
                    }, 
                  text_: "Submit",
                  ),
         
     
         ],),
     ),)
    

          

 
          ),
    

    
    );
  }
}