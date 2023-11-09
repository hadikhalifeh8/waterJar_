import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Drivers/addController.dart';
import 'package:water_jar/controller/Drivers/editController.dart';
import 'package:water_jar/core/functions/validationinput.dart';
import 'package:water_jar/view/widget/Drivers/CustomButton.dart';
import 'package:water_jar/view/widget/Drivers/CustomTextFormDriver.dart';

class EditDriver extends StatelessWidget {
  const EditDriver({super.key});

  @override
  Widget build(BuildContext context) {
    EditDriverController controller = Get.put(EditDriverController());
    return Scaffold(appBar: AppBar(

      title: const Text("Update Driver"),
      centerTitle: true,
    ),

    body:
    
     Form(
      key: controller.formState,
       child: ListView(children: [
     
        CustomTextFormDriver(
                             label_: "name",
                             hintText_: "Enter Driver name",
                             icon_:Icons.person_3,
                            // onTap_: (){},
                             isNumber: false,
                               validation: (val){
                            return  valiInput(val!, 8, 12, "name");
                             },
                             obscureText_: false,
                             mycontroller: controller.name,
                             ),
     
     
       CustomTextFormDriver(
                             label_: "Phone",
                             hintText_: "Enter Driver phone",
                             icon_:Icons.phone_iphone_outlined,
                            // onTap_: (){},
                             isNumber: true,
                             validation: (val){
                            return  valiInput(val!, 8, 12, "phone");
                             },
                             obscureText_: false,
                             mycontroller: controller.phone,
                             ),
     
     
     
            GetBuilder<EditDriverController>(builder: (controller){
              return        CustomTextFormDriver(
                             label_: "Password",
                             hintText_: "Enter Driver password",
                             icon_:Icons.lock,
                             onTap_: (){
                              controller.showPassword();
                             },
                             isNumber: false,
                                validation: (val){
                            return  valiInput(val!, 8, 12, "password");
                             },
                             obscureText_: controller.isShowPassword,
                             mycontroller: controller.password,
                             );
                             
            }),
     
     
     
     CustomButton(onPressed_: (){controller.updateData(controller.driversModel!.id.toString());}, text_: "update"),
         
     
         ],),
     ),
    
    );
  }
}