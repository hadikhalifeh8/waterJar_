import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Bottels/addController.dart';
import 'package:water_jar/controller/Customers/addController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/functions/validationinput.dart';
import 'package:water_jar/view/widget/Bottels/CustomTextFormBottels.dart';
import 'package:water_jar/view/widget/Bottels/DropDownSearchCompanies.dart';
import 'package:water_jar/view/widget/Drivers/CustomButton.dart';


class AddBottels extends StatelessWidget {
  const AddBottels({super.key});

  @override
  Widget build(BuildContext context) {
     Get.lazyPut(() =>AddBottelController());

    
    return Scaffold(appBar: AppBar(

      title: const Text("Add Bottles"),
      centerTitle: true,
    ),

    body:
          GetBuilder<AddBottelController>(builder: (controller) => 

          HandlingDataRequest(
            
            statusRequest: controller.statusRequest,
            
            
             widget:        
                     Form(
      key: controller.formState,
       child: 
       ListView(children: [
     
        CustomTextFormBottels(
                             label_: "name",
                             hintText_: "Enter Bottel name",
                             icon_:Icons.water,
                            // onTap_: (){},
                             isNumber: false,
                               validation: (val){
                            return  valiInput(val!, 2, 20, "name");
                             },
                             obscureText_: false,
                             mycontroller: controller.name,
                             inputFormatters_: false,
                             ),





             CustomDropDownSearchCompanies(
                    label: "company",
                    title: "Choose Company",
                           listdata: controller.dropdownList,
                dropDownSelectedName: controller.companyName!,
                 dropDownSelectedID: controller.companyId!, 
                
                 
                 ),                       
     
     



       CustomTextFormBottels(
                             label_: "Price",
                             hintText_: "Enter Customer price",
                             icon_:Icons.price_change_outlined,
                            // onTap_: (){},
                             isNumber: true,
                             validation: (val){
                            return  valiInput(val!, 1, 12, "price");
                             },
                             obscureText_: false,
                             mycontroller: controller.price,
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