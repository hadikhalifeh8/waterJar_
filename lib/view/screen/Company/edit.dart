import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Company/addController.dart';
import 'package:water_jar/controller/Company/editController.dart';
import 'package:water_jar/controller/Towns/addController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/functions/validationinput.dart';
import 'package:water_jar/view/widget/Company/CustomTextFormCompany.dart';
import 'package:water_jar/view/widget/Drivers/CustomButton.dart';



class EditCompany  extends StatelessWidget {
  const EditCompany ({super.key});

  @override
  Widget build(BuildContext context) {
     Get.lazyPut(() =>EditCompanyController());
    return Scaffold(appBar: AppBar(

      title: const Text("Update Company"),
      centerTitle: true,
    ),

    body:
          GetBuilder<EditCompanyController>(builder: (controller)
          =>


             //    if(controller != null) {
          HandlingDataRequest(
            
            statusRequest: controller.statusRequest,
            
            
             widget:  Form(
      key: controller.formState,
       child: ListView(children: [
     
    CustomTextFormCompany(
                                 label_: "name", 
                                 hintText_: "Enter company Name", 
                                 validation: (val){
                                  return valiInput(val!, 4, 20, "name");
                                 }, 
                                 mycontroller: controller.name,
                                 icon_: Icons.home_work, 
                                 isNumber: false, 
                                 
                                 //onTap_: () { }, 
                                 ),
     
     

     
     
     
       
     
     
     
     CustomButton(
                  onPressed_: (){
                    controller.updateData(controller.companyModels!.id.toString());
                    }, 
                  text_: "Submit",
                  ),
         
     
         ],),
     ),)
    

          

 
          ),
    

    
    );
  }
}