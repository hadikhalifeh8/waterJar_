import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Districts/editController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/functions/validationinput.dart';
import 'package:water_jar/core/shared/DropDownSearch.dart';
import 'package:water_jar/view/widget/Districts/CustomButton.dart';
import 'package:water_jar/view/widget/Districts/CustomTextFormDistrict.dart';

class EditDistrict extends StatelessWidget {
  const EditDistrict({super.key});

  @override
  Widget build(BuildContext context) {

    EditDistrictController controller = Get.put(EditDistrictController());
    return Scaffold(

      appBar: AppBar(
                     title: Text("Update District"),
                     centerTitle: true,
                    ),


  body: 
       GetBuilder<EditDistrictController>(builder: (controller) => 
       HandlingDataView(
                   statusRequest: controller.statusRequest,
                     widget:
                      Form(
                        key: controller.formState,
                        child: ListView(children: [
                      
                            CustomTextFormDistrict(
                                          label_: "name", 
                                          hintText_: "Enter District Name", 
                                          validation: (val){
                                           return valiInput(val!, 3, 15, "name");
                                          }, 
                                          mycontroller: controller.name, 
                                          icon_: Icons.add_road,
                                           isNumber: false, 
                                          ),
                      
                      
                         CustomDropDownSearch(
                                          label: "towns",
                                          title: "Choose Town",
                             listdata: controller.dropdownList,
                                      dropDownSelectedName: controller.townsName,
                                       dropDownSelectedID: controller.townsId, 
                                       
                                       ),
                      
                      
                                        CustomButton(
                          
                         onPressed_: (){
                          controller.updateData(controller.districtsModel!.id.toString());
                         },
                        
                                           text_: "Update"
                                           
                                           ),  
                      
                        ],),
                      ),)
  
  )

    );
  }
}