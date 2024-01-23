import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Admin/loginController.dart';
import 'package:water_jar/core/constant/imageasset.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/view/widget/Admin/CustomHomeGridView.dart';

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key});

  @override
  Widget build(BuildContext context) {

    LoginController controller = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,    
        ),

        body: ListView(children: [
          GridView(
            
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 130.0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,

            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),


            children: [

             CustomHomeGridView(image: (AppImageAsset.driver), title: "Driver", onClick: (){Get.toNamed(AppRoute.driversview);}),
              CustomHomeGridView(image: (AppImageAsset.town), title: "Town",onClick: (){Get.toNamed(AppRoute.townview);}),
              CustomHomeGridView(image: (AppImageAsset.district), title: "District", onClick: (){Get.toNamed(AppRoute.districtview);}),
              CustomHomeGridView(image: (AppImageAsset.customer), title: "Customer",onClick: (){Get.toNamed(AppRoute.customerview);}),
              CustomHomeGridView(image: (AppImageAsset.company), title: "Company", onClick: (){Get.toNamed(AppRoute.companyview);}),
              CustomHomeGridView(image: (AppImageAsset.bottel), title: "Bottels", onClick: (){Get.toNamed(AppRoute.bottelsview);}),

            ],
          ),
          const SizedBox(height: 30.0,),


          InkWell(
            onTap: (){
              controller.logout();
            },
            
            child: Image.asset(AppImageAsset.logout, height: 40.0 )
            ),

         

        ],),
    );
  }
}