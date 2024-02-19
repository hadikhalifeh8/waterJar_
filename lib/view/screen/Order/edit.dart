import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_jar/controller/Orders/addController.dart';
import 'package:water_jar/controller/Orders/editController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/core/functions/validationinput.dart';
import 'package:water_jar/view/widget/Orders/CustomButton.dart';
import 'package:water_jar/view/widget/Orders/CustomTextFormOrdersForGetPrices.dart';
import 'package:water_jar/view/widget/Orders/CustomTextFormOrdersForINTEGERS.dart';
import 'package:water_jar/view/widget/Orders/DropDownSearchOrders.dart';


class EditOrder extends StatelessWidget {
  const EditOrder({super.key});

  @override
  Widget build(BuildContext context) {
     Get.lazyPut(() =>EditOrderController());
   
//  ViewOrdersController ordersController =  Get.put(ViewOrdersController());

    
    return Scaffold(appBar: AppBar(

      title: const Text("Update Order"),
      centerTitle: true,
    ),

    body:
          GetBuilder<EditOrderController>(builder: (controller) => 

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
                    padding: const EdgeInsets.only( right: 15.0),
                    child: Text(controller.myservices.sharedPreferences.getString("name").toString(), style: const TextStyle(fontSize: 20, color:Colors.red)),
                  ),
                 
                  
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                    child: Text(controller.ordersModel!.dayName.toString(),style: const TextStyle(fontSize: 18, color: Colors.blue))
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
                     Expanded(child: Text(controller.ordersModel!.customerName.toString(), style: const TextStyle(fontSize: 15),)),

                      
   

            Expanded(child: Text(controller.ordersModel!.townName.toString(), style: const TextStyle(fontSize: 15),)),
            Expanded(child: Text(controller.ordersModel!.districtName.toString(), style: const TextStyle(fontSize: 15))),

                    ],
                  ),


Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => controller.toggleContainers(true, false),
                  child: const Text('Bottels'),
                ),
                ElevatedButton(
                  onPressed: () => controller.toggleContainers(false, true),
                  child: const Text('Jars'),
                ),
              ],
            ),
             const SizedBox(height: 20),



// Start Container For Bottels

    Visibility(
              visible: controller.showContainerA,
              child:
              
    Container(
                // padding: const EdgeInsets.all(16),
                // color: Colors.blue,
                child:
     Column(children: [

      Row(children: [


        Expanded(
             child: CustomDropDownSearchOrders(
                          label: "bottels",
                          title: "Choose Bottels",
                          listdata: controller.dropdownListOFBottels,
                          dropDownSelectedName: controller.bottelsName,
                          dropDownSelectedID: controller.bottelsId, 
                          onTownChanged: controller.onBottlesChanged,

                      // onTownChanged: (String? value)
                      // {
                      //     controller.onBottlesFORJARChanged(value);
                       
                      //      controller.onBottlesChanged(value);
                        
                      //   }
                       
                       ),
          ),


           Expanded(
             child: CustomTextFormOrdersForGetPrices(
                                       

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

      
      
      ],),




      Row(children: [
          Expanded(
                  // becouse input formater  8ayaret l custom resource from botels to jars
                   child: CustomTextFormOrdersForINTEGERS(
                                         label_: "Qty bottels", 
                                         hintText_: "qty Of Bottels", 
                                         
                                         validation: (val){
                                         if (controller.bottelsId.text.isNotEmpty){
                                          return valiInput(val!, 1, 100, "");
                                         }
                                         return null;
                             //  return valiInput(val!, 3, 15, "");
                              }, 
                                      
                                      
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
                    CustomTextFormOrdersForGetPrices(
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
                 ), 

                  ],)
                ],),
              ),
            ),

        /////////////////////////////////////  End Container For Bottels  // 







/******************************************************************************************* */





// Start Container For Jars
        
     Visibility(
              visible: controller.showContainerB,
              child:

      Container(
                // padding: const EdgeInsets.all(16),
                // color: Colors.green,
                child: 
        Column(children: [
          Center(child: Text(controller.jarsName.text, style: const TextStyle(fontSize: 15),)),
SizedBox(height: 20.0,),
          Row(children: [

            Expanded(child:

             CustomTextFormOrdersForINTEGERS(
                                  label_: "qty_jar_in",
                                  hintText_: "jar_in", 
                                  icon_: Icons.water_drop_rounded,
                                  mycontroller:controller.jarIn,
                                  isNumber: true, 
                                  inputFormatters_: true,
                                  // readOnly_: controller.bottelsId.text.isEmpty ? true : false,
                                   readOnly_: false,
                                   
                                   validation: (val){
                                              if(controller.jarsId.text.isNotEmpty) {
                                               return valiInput(val!, 1, 100, "");
                                              }
                                        return null; 
                                     },


                                   onChanged_: controller.onBottlesFORJARChanged,

  
                                  )  ,
  
    
  
            ), 
  
    
            Expanded(child:
             CustomTextFormOrdersForINTEGERS(
                                   label_: "qty_jar_out",
                                  hintText_: "jar_out",
                                  icon_: Icons.water_drop_rounded,
                                  mycontroller:controller.jarOut,
                                  isNumber: true,
                                  inputFormatters_: true,
                                  // readOnly_: controller.bottelsId.text.isEmpty ? true : false,
                                   readOnly_: false,

                                   validation: (val){
                                              if(controller.jarsId.text.isNotEmpty) {
                                               return valiInput(val!, 1, 100, "");
                                              }
                                        return null; 
                                     },
                                  
                                  onChanged_: controller.onBottlesFORJARChanged,
  
                                  )  ,
  
    
  
            ), 
  
      ],),

      Row(children: [
          
    
  
            Expanded(child:
             CustomTextFormOrdersForINTEGERS(
                                  label_: "qty_previous_jars",
                                  hintText_: "qty_previous_jars",
                                  icon_: Icons.water_drop_rounded,
                                  mycontroller:controller.qtyPreviousOFJars,
                                  isNumber: true,
                                  inputFormatters_: true,
                                  // readOnly_: controller.bottelsId.text.isEmpty ? true : false,
                                   readOnly_: false,

                                   validation: (val){
                                              if(controller.jarsId.text.isNotEmpty) {
                                               return valiInput(val!, 1, 100, "");
                                              }
                                        return null; 
                                     },

                                  onChanged_: controller.onBottlesFORJARChanged,
  
                                  )  ,
  
            ),       
    
  
            Expanded(child:
             CustomTextFormOrdersForINTEGERS(
                                  label_: "total qty Jar",
                                  hintText_: "total_Jar", 
                                  icon_: Icons.water_drop_rounded,
                                  isNumber: true,
                                  mycontroller: controller.totalJars ,
                                  inputFormatters_: true,
                                  readOnly_: true,
  
                                  ),
  
            ),
      ],),

    Row(children: [
            Expanded(
              child: CustomTextFormOrdersForGetPrices(
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
                                  onChanged_: controller.onBottlesFORJARChanged,

  
                                        ),
            ),
  
    
            Expanded(
                  child: CustomTextFormOrdersForGetPrices(
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

    ],),
                ],),
              ),
            ),


      /////// End Container For Jars  ////////////////////// // 
          ],
        ),



       
const SizedBox(height: 40.0,),

         Row(children: [

           Expanded(
                  child: CustomTextFormOrdersForGetPrices(
                                         label_: "Paid", 
                                         hintText_: "Paid", 

                                         validation: (val){
                                        if(controller.bottelsId.text.isNotEmpty) {
                                          
                                          return valiInput(val!, 1, 100, "");
                                        }
                                        

                                       else if(controller.jarsId.text.isNotEmpty) {
                                          
                                          return valiInput(val!, 1, 100, "");
                                        }

                                        return null; 

                                        

                               
                              }, 
                                        mycontroller:controller.paid,  
                                        icon_: Icons.monetization_on, 
                                        isNumber: true, 
                                       //  obscureText_: obscureText_, 
                                        inputFormatters_: true,
                                      //  readOnly_: false,
                                    // readOnly_: controller.bottelsId.text.isEmpty ? true : false || controller.jarsId.text.isEmpty ? true : false,
                                  readOnly_: (controller.bottelsId.text.isEmpty && controller.jarsId.text.isEmpty) ? true : false ,
                                  // onChanged_: controller.onBottlesChanged,

                                   onChanged_: ($value){
                                    if(controller.bottelsId.text.isNotEmpty){

                                      controller.onBottlesChanged($value);

                                    } else if (controller.jarsId.text.isNotEmpty){

                                      controller.onBottlesFORJARChanged($value);

                                    }
                                          
                                          
                                        }
                                   
                                    ),                
  
            ),


             Expanded(
              // newDebt is = => oldDebt in AddOrder is = 0
                  child: CustomTextFormOrdersForGetPrices(
                                         label_: "New debt", 
                                         hintText_: "New debt", 
                              //            validation: (val){
                              //  return valiInput(val!, 3, 15, "");
                              // }, 
                                        mycontroller:controller.oldDebt,  
                                        icon_: Icons.monetization_on, 
                                        isNumber: true, 
                                       //  obscureText_: obscureText_, 
                                        inputFormatters_: true,
                                        readOnly_: true,
                                        // onChanged_: ($value){
                                        //   controller.onBottlesChanged($value);
                                        //   controller.onBottlesFORJARChanged($value);
                                        // }
                                        
                                    ),
  
            ),





         ],),
         Divider(),
// oldDebt is the ==> newDebt in AddOrder
         CustomTextFormOrdersForGetPrices(
                                         label_: "Old debt", 
                                         hintText_: "Old debt", 
                              //            validation: (val){
                              //  return valiInput(val!, 3, 15, "");
                              // }, 
                                        mycontroller:controller.newDebt,  
                                        icon_: Icons.monetization_on, 
                                        isNumber: true, 
                                       //  obscureText_: obscureText_, 
                                        inputFormatters_: true,
                                        readOnly_: true,
                                        // onChanged_: ($value){
                                        //   controller.onBottlesChanged($value);
                                        //   controller.onBottlesFORJARChanged($value);
                                        // }
                                        
                                    ),

    
const SizedBox(height: 40.0,),

    CustomTextFormOrdersForGetPrices(
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
                       onPressed_: (){
                        controller.updateData(controller.ordersModel!.id.toString());
                        },
                       text_: "Update Order",
                       ),

                  

                  //  CustomButtonOrder(
                  //      onPressed_: (){ordersController.readData();},
                  //      text_: "View My Orders",
                  //      ),


               //   const SizedBox(height: 15.0,),


          // InkWell(
          //   onTap: (){
          //     controller.logout();
          //   },
            
          //   child: Image.asset(AppImageAsset.logout, height: 40.0 )
          //   ),     

                        



    ],), 
     
     
     
         
     ),)

          
          )

    
    );
  }
}