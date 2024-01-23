import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Days/addController.dart';
import 'package:water_jar/controller/Days/viewController.dart';
import 'package:water_jar/controller/Orders/viewController.dart';
import 'package:water_jar/core/constant/imageasset.dart';
import 'package:water_jar/view/widget/Days/CustomNameOfDays.dart';
import 'package:water_jar/view/widget/Orders/CustomButton.dart';

class ViewDays extends StatelessWidget {
  const ViewDays({super.key});

  @override
  Widget build(BuildContext context) {
    ViewDaysController controller = Get.put(ViewDaysController());
      AddDaysController addcontroller = Get.put(AddDaysController());
      // ViewOrdersController controllerDel = Get.put(ViewOrdersController());
    return Scaffold( appBar: 
      AppBar(   
                  title: const Text("Days"), 
                   centerTitle: true,
                   
                   
                   
           leading: IconButton(
                onPressed: (){
                    addcontroller.insertData();
                   }, 
                   icon: Icon(Icons.add_box_outlined)
                   ),

     ),
                  

                  body: (controller.loading ==null ?  Center(child: Text("loading"),) :
                  GetBuilder<ViewDaysController>(builder: (controller) =>
                
                
                 


                        ListView(children: [


                 GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.8), 
                  
                  
                  itemCount: controller.day.length,
                  itemBuilder: (context, index) {

            return  CustomNameOfDays(
              
              onTap_:(){
            
               controller.goToOrderPage(controller.day[index]);
                } , 
            
            
            svgPicture_:  SvgPicture.asset(controller.day[index].image.toString()),
            );
            
                
                
                
                
                // CustomNameOfDays(onTap_:(){} , svgPicture_:  SvgPicture.asset(AppImageAsset.tuesday),);   
                // CustomNameOfDays(onTap_:(){} , svgPicture_:  SvgPicture.asset(AppImageAsset.wednesday),);  
                // CustomNameOfDays(onTap_:(){} , svgPicture_:  SvgPicture.asset(AppImageAsset.thursday),);  
                // CustomNameOfDays(onTap_:(){} , svgPicture_:  SvgPicture.asset(AppImageAsset.friday),);  
                // CustomNameOfDays(onTap_:(){} , svgPicture_:  SvgPicture.asset(AppImageAsset.saturday));

                    
                  },),

                      //        CustomButtonOrder(
                      //  onPressed_: (){controllerDel.removeData();},
                      //  text_: "delete Orders",
                      //  ),
                  
                  
                  
                 
                  ],),                  
                  
                   )
                  
                  
                  
                  
                  ), 

                  
                  
             
            //        bottomNavigationBar: Container( color: Colors.green.shade300
            
            // ,child: 
          
            //             MaterialButton(onPressed: () async{
            //             await  controller.sqlDb.myDeleteDataBase();
                      
            //             }, 
            //             child: Text("Delete My DataBase"),
            //             )),
            
    
    
    );
               
                  
                            
                

  }
}