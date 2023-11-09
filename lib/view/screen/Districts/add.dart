import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Districts/addController.dart';
import 'package:water_jar/core/functions/validationinput.dart';
import 'package:water_jar/core/shared/DropDownSearch.dart';
import 'package:water_jar/view/widget/Districts/CustomTextFormDistrict.dart';
import 'package:water_jar/view/widget/Drivers/CustomButton.dart';

class AddDistrict extends StatelessWidget {
  const AddDistrict({super.key});

  @override
  Widget build(BuildContext context) {
     Get.lazyPut(() =>AddDistrictController());
 // AddDistrictController controller = Get.put(AddDistrictController());


    return Scaffold(

      appBar: AppBar(
                      title: const Text("Add District"),
                      centerTitle: true, 
                      ),
              
              
              body:
              
             GetBuilder<AddDistrictController>(builder: (controller) => 
             

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
                dropDownSelectedName: controller.townsName!,
                 dropDownSelectedID: controller.townsId!, 
                 
                 ),
              
              
              
                      CustomButton(
                        
                       onPressed_: (){
                        controller.insertData();
                       },
                      
                     text_: "Submit"
                     
                     ),       
              
              
              
                        //          TextFormField(
                        // controller: controller.dropdownName,
                        // cursorColor: Colors.black,
                        // onTap: controller.dropdownName
                
                        //     ,
                      //   decoration: InputDecoration(
                      //     filled: true,
                      //     fillColor: Colors.black12,
                      //     contentPadding:
                      //         const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
                      //     hintText:"choose",
                      //     border: const OutlineInputBorder(
                      //       borderSide: BorderSide(
                      //         width: 0,
                      //         style: BorderStyle.none,
                      //       ),
                      //       borderRadius: BorderRadius.all(
                      //         Radius.circular(8.0),
                      //       ),
                      //     ),
                      //   ),
                      // ),
              
                ],),
              ) ,
             
             ),
    );
  }
}