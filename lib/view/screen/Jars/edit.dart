import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Jars/addController.dart';
import 'package:water_jar/controller/Jars/editController.dart';
import 'package:water_jar/controller/Towns/addController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/functions/validationinput.dart';
import 'package:water_jar/view/widget/Jars/CustomTextFormJars.dart';
import 'package:water_jar/view/widget/Drivers/CustomButton.dart';



class EditJar  extends StatelessWidget {
  const EditJar ({super.key});

  @override
  Widget build(BuildContext context) {
     Get.lazyPut(() =>EditJarController());
    return Scaffold(appBar: AppBar(

      title: const Text("Update Jar"),
      centerTitle: true,
    ),

    body:
          GetBuilder<EditJarController>(builder: (controller)
          =>


             //    if(controller != null) {
          HandlingDataRequest(
            
            statusRequest: controller.statusRequest,
            
            
             widget:  Form(
      key: controller.formState,
       child: ListView(children: [
     
    CustomTextFormJars(
                                 label_: "name", 
                                 hintText_: "Enter company Name", 
                                 validation: (val){
                                  return valiInput(val!, 2, 20, "name");
                                 }, 
                                 mycontroller: controller.name,
                                 icon_: Icons.home_work, 
                                 isNumber: false, 
                                 inputFormatters_: false,
                                 
                                 //onTap_: () { }, 
                                 ),

                   CustomTextFormJars(
                                 label_: "price", 
                                 hintText_: "Enter jar price", 
                                 validation: (val){
                                  return valiInput(val!, 1, 20, "");
                                 }, 
                                 mycontroller: controller.price,
                                 icon_: Icons.home_work, 
                                 isNumber: true, 
                                 inputFormatters_: true,
                                 
                                 //onTap_: () { }, 
                                 ),
     
     

     
     
     
       
     
     
     
     CustomButton(
                  onPressed_: (){
                    controller.updateData(controller.jarModels!.id.toString());
                    }, 
                  text_: "Submit",
                  ),
         
     
         ],),
     ),)
    

          

 
          ),
    

    
    );
  }
}