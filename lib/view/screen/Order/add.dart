import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_jar/controller/Customers/addController.dart';
import 'package:water_jar/controller/Orders/addController.dart';
import 'package:water_jar/controller/Orders/viewController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/validationinput.dart';
import 'package:water_jar/core/shared/DropDownSearch.dart';
import 'package:water_jar/view/widget/Customers/CustomTextFormCustomer.dart';
import 'package:water_jar/view/widget/Drivers/CustomButton.dart';
import 'package:water_jar/view/widget/Orders/CustomButton.dart';
import 'package:water_jar/view/widget/Orders/CustomTextFormOrdersForJars.dart';
import 'package:water_jar/view/widget/Orders/CustomTextFormOrdersForPrice.dart';
import 'package:water_jar/view/widget/Orders/DropDownSearchOrders.dart';


class AddOrder extends StatelessWidget {
  const AddOrder({super.key});

  @override
  Widget build(BuildContext context) {
     Get.lazyPut(() =>AddOrderController());
   


    
    return Scaffold(appBar: AppBar(

      title: const Text("Add Order"),
      centerTitle: true,
    ),

    body:
          GetBuilder<AddOrderController>(builder: (controller) => 

          HandlingDataRequest(
            
            statusRequest: controller.statusRequest,
            
            
             widget:        
                     Form(
      key: controller.formState,
       child: 
       ListView(children: [

                  Container( 
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(5.0),
 
          
            child: Row(
              mainAxisSize: MainAxisSize.min,
                children: [

                     Container(
                    padding: const EdgeInsets.only(left: 1.0, right: 15.0),
                    child: Text("${controller.myservices.sharedPreferences.getString("name").toString()}", style: const TextStyle(fontSize: 20, color:Colors.red)),
                  ),
                 
                  
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                    child: Text(controller.daysModel!.name.toString(),style: const TextStyle(fontSize: 20, color: Colors.blue))
                  ),
                  
                  
               Container(
                    padding: const EdgeInsets.only(left: 15.0),

                child: Text(DateFormat('dd-MM-yyyy').format(DateTime.now()),style: TextStyle(fontSize: 16, color: Colors.red))
               ),

           
              
          
                ],
              ),
          ),
     

     
     



       Row(
         children: [
           Expanded(
             child: CustomDropDownSearchOrders(
                          label: "towns",
                          title: "Choose Town",
                                 listdata: controller.dropdownListOFTowns,
                      dropDownSelectedName: controller.townName,
                       dropDownSelectedID: controller.townId,
                         onTownChanged: controller.onTownChanged, // Pass the onTownChanged callback
                       
                    
                       
                       ),
           ),


           Expanded(
             child: CustomDropDownSearchOrders(
                          label: "districts",
                          title: "Choose District",
                                 listdata: controller.dropdownListOFDistricts,
                      dropDownSelectedName: controller.districtName,
                       dropDownSelectedID: controller.districtId, 
                       onTownChanged: controller.onDistrictChanged, // Pass the onDistrictChanged callback
                      
                       
                       ),
           ),
         ],
       ),


              CustomDropDownSearchOrders(
                                   label: "Customers", 
                                   title: "Enter Customers", 
                                   listdata: controller.dropdownListOFCustomers,
                                   dropDownSelectedName: controller.customerName,
                                   dropDownSelectedID: controller.customerId,
                                   
         ),


    
       Row(
         children: [
           Expanded(
             child: CustomDropDownSearchOrders(
                          label: "companies",
                          title: "Choose Company",
                                 listdata: controller.dropdownListOFCompanies,
                      dropDownSelectedName: controller.companiesName,
                       dropDownSelectedID: controller.companiesId,
                     onTownChanged: controller.onCompanyChanged, // Pass the onCompanyChanged callback
                       
                    
                       ),
           ),


           Expanded(
             child: CustomDropDownSearchOrders(
                          label: "bottels",
                          title: "Choose Bottels",
                                 listdata: controller.dropdownListOFBottels,
                      dropDownSelectedName: controller.bottelsName,
                       dropDownSelectedID: controller.bottelsId, 
                      //  onTownChanged: controller.onBottlesChanged,

                      onTownChanged: (String? value)
                      {
                        controller.onBottlesChanged(value);
                          
                        controller.onBottlesFORJARChanged(value);
                      }

                         
                      
                       

                      
                      
                       
                       ),
           ),
         ],
       ),     




         Row(
           children: [
            
             Expanded(
              // becouse input formater  8ayaret l custom resource from botels to jars
               child: CustomTextFormOrdersForJars(
                                     label_: "Qty bottels", 
                                     hintText_: "qty Of Bottels", 
                          //            validation: (val){
                          //  return valiInput(val!, 3, 15, "");
                          // }, 
                                  
                                  
                                   mycontroller:  controller.qtyOfBottles ,
                                     icon_: Icons.onetwothree_outlined, 
                                     isNumber: true, 
                                   //  obscureText_: obscureText_, 
                                     inputFormatters_: true,
                                     readOnly_: controller.bottelsId.text.isEmpty ? true : false,

                                     onChanged_: controller.onBottlesChanged,

                  ),
             ),


              Expanded(
               child:
                CustomTextFormOrdersForJars(
                                     label_: "price per bottel", 
                                     hintText_: "price Per Bottels", 
                          //            validation: (val){
                          //  return valiInput(val!, 3, 15, "");
                          // }, 
                                 

                                     mycontroller: controller.pricePerBottel,
                                     icon_: Icons.monetization_on, 
                                     isNumber: true, 
                                   //  obscureText_: obscureText_, 
                                     inputFormatters_: true,
                                     readOnly_: true,
                                    

                  ),
             ), 



           ],
         ),  


                         CustomTextFormOrdersForJars(
                                     label_: "total price bottels", 
                                     hintText_: "total price Bottels", 
                          //            validation: (val){
                          //  return valiInput(val!, 3, 15, "");
                          // }, 
                                     mycontroller:controller.totalPriceBottel,
                                     icon_: Icons.monetization_on, 
                                     isNumber: true, 
                                   //  obscureText_: obscureText_, 
                                     inputFormatters_: true,
                                     readOnly_: true,

                             

                  ),
             





          Row(children: [
    Expanded(child:
                          
                          
        CustomTextFormOrdersForJars(
                              label_: "qty_jar_in",
                              hintText_: "jar_in", 
                              icon_: Icons.water_drop_rounded,
                                     mycontroller:controller.jarIn,

                              isNumber: true, 
                              inputFormatters_: true,
                              readOnly_: controller.bottelsId.text.isEmpty ? true : false,

                              onChanged_: controller.onBottlesFORJARChanged,
                              
                             
                              )  ,
                             ), 

     Expanded(child:
                          
                          
        CustomTextFormOrdersForJars(label_: "qty_jar_out",
                              hintText_: "jar_out",
                              icon_: Icons.water_drop_rounded,
                              mycontroller:controller.jarOut,

                               isNumber: true,
                              inputFormatters_: true,
                              readOnly_: controller.bottelsId.text.isEmpty ? true : false,

                              onChanged_: controller.onBottlesFORJARChanged,


                                
                                )  ,
                             ), 





    Expanded(child:
        CustomTextFormOrdersForJars(label_: "qty_previous_jars",
                              hintText_: "qty_previous_jars",
                              icon_: Icons.water_drop_rounded,
                              mycontroller:controller.qtyPreviousOFJars,

                               isNumber: true,
                              inputFormatters_: true,
                              readOnly_: controller.bottelsId.text.isEmpty ? true : false,

                              onChanged_: controller.onBottlesFORJARChanged,


                                
                                )  ,
                             ),       

      Expanded(child:
                          
                          
         CustomTextFormOrdersForJars(
                              label_: "total qty Jar",
                              hintText_: "total_Jar", 
                              icon_: Icons.water_drop_rounded,
                              isNumber: true,
                              mycontroller: controller.totalJars ,
                               inputFormatters_: true,
                              readOnly_: true,

                               
                               )  ,
                             ), 


                        ],
        ),        

          
          



  Row(
      children: [
        Expanded(
          child: CustomTextFormOrdersForJars(
                                     label_: "price per jar", 
                                     hintText_: "Price Per Jar", 
                          //            validation: (val){
                          //  return valiInput(val!, 3, 15, "");
                          // }, 
                                     mycontroller:controller.pricePerJar,
                                     icon_: Icons.monetization_on, 
                                     isNumber: true, 
                                   //  obscureText_: obscureText_, 
                                     inputFormatters_: true,
                                     readOnly_: true,
                  ),
        ),


        Expanded(
              child: CustomTextFormOrdersForJars(
                                     label_: "total price jar", 
                                     hintText_: "Total Price Jar", 
                          //            validation: (val){
                          //  return valiInput(val!, 3, 15, "");
                          // }, 
                                     mycontroller:controller.totalPriceJars,  
                                     icon_: Icons.monetization_on, 
                                     isNumber: true, 
                                   //  obscureText_: obscureText_, 
                                     inputFormatters_: true,
                                     readOnly_: true,

                  ),
            ),
      ],
    ),

    CustomTextFormOrdersForJars(
                                     label_: "total price", 
                                     hintText_: "Total Price", 
                          //            validation: (val){
                          //  return valiInput(val!, 3, 15, "");
                          // }, 
                                     mycontroller:controller.totalPrice,  
                                     icon_: Icons.monetization_on, 
                                     isNumber: true, 
                                   //  obscureText_: obscureText_, 
                                     inputFormatters_: true,
                                     readOnly_: true,

                  ),


      CustomButtonOrder(
                       onPressed_: (){controller.insertData();},
                       text_: "Order Now",
                       ),

                  

                   CustomButtonOrder(
                       onPressed_: (){Get.toNamed(AppRoute.ordersViewBydriverid);},
                       text_: "View My Orders",
                       ),

                        



    ],), 
     
     
     
         
     ),)

          
          )

    
    );
  }
}