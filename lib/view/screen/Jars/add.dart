import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Jars/addController.dart';
import 'package:water_jar/controller/Towns/addController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/functions/validationinput.dart';
import 'package:water_jar/view/widget/Jars/CustomTextFormJars.dart';
import 'package:water_jar/view/widget/Drivers/CustomButton.dart';



class AddJar  extends StatelessWidget {
  const AddJar ({super.key});

  @override
  Widget build(BuildContext context) {
     Get.lazyPut(() =>AddJarController());
    return Scaffold(appBar: AppBar(

      title: const Text("Add Jar"),
      centerTitle: true,
    ),

    body:
          GetBuilder<AddJarController>(builder: (controller)
          =>


             //    if(controller != null) {
          HandlingDataRequest(
            
            statusRequest: controller.statusRequest,
            
            
             widget:  Form(
      key: controller.formState,
       child: ListView(children: [
     
    CustomTextFormJars(
                                 label_: "name", 
                                 hintText_: "Enter jar Name", 
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