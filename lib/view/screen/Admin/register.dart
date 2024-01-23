import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Admin/registerController.dart';
import 'package:water_jar/controller/Drivers/addController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/constant/imageasset.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/validationinput.dart';
import 'package:water_jar/view/widget/Admin/CustomTextFormRegsiterLogin.dart';
import 'package:water_jar/view/widget/Admin/CustomTextRegisterORLogin.dart';
import 'package:water_jar/view/widget/Drivers/CustomButton.dart';
import 'package:water_jar/view/widget/Drivers/CustomTextFormDriver.dart';

class AdminRegister extends StatelessWidget {
  const AdminRegister({super.key});

  @override
  Widget build(BuildContext context) {
     Get.lazyPut(() =>RegisterController());

    
    return Scaffold(appBar: AppBar(

      title: const Text("Register"),
      centerTitle: true,
    ),

    body:
          GetBuilder<RegisterController>(builder: (controller) => 

          HandlingDataRequest(
            
            statusRequest: controller.statusRequest,
            
            
             widget:                Form(
      key: controller.formState,
       child: ListView(children: [


             Container(
                 margin: const EdgeInsets.only(top: 10.0),
      child: Image.asset(AppImageAsset.AdminRegister, height: 105.0 )),



        CustomTextFormRegsiterLogin(
                             label_: "name",
                             hintText_: "Enter admin name",
                             icon_:Icons.person_3,
                            // onTap_: (){},
                             isNumber: false,
                               validation: (val){
                            return  valiInput(val!, 8, 12, "name");
                             },
                             obscureText_: false,
                             mycontroller: controller.name,
                             inputFormatters_: false,

                             ),
     
     
       CustomTextFormRegsiterLogin(
                             label_: "Phone",
                             hintText_: "Enter admin phone",
                             icon_:Icons.phone_iphone_outlined,
                            // onTap_: (){},
                             isNumber: true,
                             validation: (val){
                            return  valiInput(val!, 8, 12, "phone");
                             },
                             obscureText_: false,
                             mycontroller: controller.phone,
                             inputFormatters_: true,
                             ),
     
     
     
            GetBuilder<RegisterController>(builder: (controller){
              return        CustomTextFormRegsiterLogin(
                             label_: "Password",
                             hintText_: "Enter admin password",
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
                             inputFormatters_: false,

                             );
                             
            }),
     
     
     
     CustomButton(
                  onPressed_: (){
                    controller.registerData();
                    }, 
                  text_: "Submit",
                  ),


         CustomTextRegisterORLogin(
                                  textOne: "Already Register, ",
                                  textTwo: "SignIn",
                                  onTap: (){Get.toNamed(AppRoute.adminlogin);}
                                  ),
         
     
         ],),
     ),)

          ),
    

    
    );
  }
}