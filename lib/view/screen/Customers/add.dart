import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Customers/addController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/functions/validationinput.dart';
import 'package:water_jar/core/shared/DropDownSearch.dart';
import 'package:water_jar/view/widget/Customers/CustomTextFormCustomer.dart';
import 'package:water_jar/view/widget/Drivers/CustomButton.dart';


class AddCustomer extends StatelessWidget {
  const AddCustomer({super.key});

  @override
  Widget build(BuildContext context) {
     Get.lazyPut(() =>AddCustomerController());

    
    return Scaffold(appBar: AppBar(

      title: const Text("Add Customer"),
      centerTitle: true,
    ),

    body:
          GetBuilder<AddCustomerController>(builder: (controller) => 

          HandlingDataRequest(
            
            statusRequest: controller.statusRequest,
            
            
             widget:        
                     Form(
      key: controller.formState,
       child: 
       ListView(children: [
     
        CustomTextFormCustomer(
                             label_: "name",
                             hintText_: "Enter Customer name",
                             icon_:Icons.person_3,
                            // onTap_: (){},
                             isNumber: false,
                               validation: (val){
                            return  valiInput(val!, 8, 20, "name");
                             },
                             obscureText_: false,
                             mycontroller: controller.name,
                             ),
     
     
       CustomTextFormCustomer(
                             label_: "Phone",
                             hintText_: "Enter Customer phone",
                             icon_:Icons.phone_iphone_outlined,
                            // onTap_: (){},
                             isNumber: true,
                             validation: (val){
                            return  valiInput(val!, 8, 12, "phone");
                             },
                             obscureText_: false,
                             mycontroller: controller.phone,
                             ),


       CustomDropDownSearch(
                    label: "towns",
                    title: "Choose Town",
                           listdata: controller.dropdownListOFTowns,
                dropDownSelectedName: controller.townsName,
                 dropDownSelectedID: controller.townsId,
                   onTownChanged: controller.onTownChanged, // Pass the onTownChanged callback
                 
              
                 
                 ),


       CustomDropDownSearch(
                    label: "districts",
                    title: "Choose District",
                           listdata: controller.dropdownListOFDistricts,
                dropDownSelectedName: controller.districtsName,
                 dropDownSelectedID: controller.districtsId, 
                
                 
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