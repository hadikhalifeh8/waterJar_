import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Admin/loginController.dart';
import 'package:water_jar/controller/Orders/viewController.dart';
import 'package:water_jar/core/constant/imageasset.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/view/widget/Admin/CustomHomeGridView.dart';
import 'package:water_jar/view/widget/Orders/CustomButton.dart';

class OrdersHomePage extends StatelessWidget {
  const OrdersHomePage({super.key});

  @override
  Widget build(BuildContext context) {

 //   LoginController controller = Get.put(LoginController());
  ViewOrdersController Controller =  Get.put(ViewOrdersController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders Dashboard"),
        centerTitle: true,    
        ),

        body: ListView( shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),children: [
          GridView(
            
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 130.0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,

            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),




            children: [

              CustomHomeGridView(image: (AppImageAsset.newOrder), title: "New Order", onClick: (){Get.toNamed(AppRoute.viewdays);}),
              CustomHomeGridView(image: (AppImageAsset.preOrder), title: "Pre-Order",onClick: (){Get.toNamed(AppRoute.viewdays);}),
              

            ],
          ),
          const SizedBox(height: 80.0,),

             
                       
        //                       ListView.builder(
        //   shrinkWrap: true,
        //  physics: const NeverScrollableScrollPhysics(),

        //   itemCount: Controller.orders.length,
          
        //   itemBuilder: (context, index) => 

        //     CustomButtonOrder(
        //                onPressed_: ()
        //                {Controller.readData(Controller.orders[index].driverId.toString());},
        //                text_: "View My Orders",
        //                ),
          
            
        //  ),
           
              

     CustomButtonOrder(
                       onPressed_: ()
                       {
                        Controller.readData();
                        },
                       text_: "View My Orders",
                       ),
        
           


                    InkWell(
            onTap: (){
              Controller.logout();
            },
            
            child: Image.asset(AppImageAsset.logout, height: 40.0 )
            ),  

            //  CustomButtonOrder(
            //            onPressed_: ()
            //            {Controller.readData(Controller.orders[index].driverId.toString());},
            //            text_: "View My Orders",
            //            ),

         

        ],),
    );
  }
}