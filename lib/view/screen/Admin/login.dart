import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Admin/loginController.dart';
import 'package:water_jar/controller/Drivers/addController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/constant/imageasset.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/validationinput.dart';
import 'package:water_jar/view/widget/Admin/CustomTextRegisterORLogin.dart';
import 'package:water_jar/view/widget/Drivers/CustomButton.dart';
import 'package:water_jar/view/widget/Drivers/CustomTextFormDriver.dart';

class AdminLogin extends StatelessWidget {
  const AdminLogin({super.key});

  @override
  Widget build(BuildContext context) {
     Get.lazyPut(() =>LoginController());

    
    return Scaffold(appBar: AppBar(

      title: const Text("Admin Login"),
      centerTitle: true,
    ),

    body:
          GetBuilder<LoginController>(builder: (controller) => 

          HandlingDataRequest(
            
            statusRequest: controller.statusRequest,
            
            
             widget:                Form(
      key: controller.formState,
       child: ListView(children: [
     

     Container(
                 margin: const EdgeInsets.only(top: 10.0),
      child: Image.asset(AppImageAsset.adminLogin, height: 105.0 )),
     
       CustomTextFormDriver(
                             label_: "Phone",
                             hintText_: "Enter phone number",
                             icon_:Icons.phone_iphone_outlined,
                            // onTap_: (){},
                             isNumber: true,
                             validation: (val){
                            return  valiInput(val!, 8, 12, "phone");
                             },
                             obscureText_: false,
                             mycontroller: controller.phone,
                             ),
     
     
     
            GetBuilder<LoginController>(builder: (controller){
              return        CustomTextFormDriver(
                             label_: "Password",
                             hintText_: "Enter password",
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
     
     
     
     CustomButton(
                  onPressed_: (){
                    controller.loginData();
                    }, 
                  text_: "Submit",
                  ),


         
                 CustomTextRegisterORLogin(
                                  textOne: "Not Registered yet, ",
                                  textTwo: "SignUp",
                                  onTap: (){Get.offAllNamed(AppRoute.adminregister);}
                                  ),


         
     
         ],),
     ),)

          ),
    

    
    );
  }
}