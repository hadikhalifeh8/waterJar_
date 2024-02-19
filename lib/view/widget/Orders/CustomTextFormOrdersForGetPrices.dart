import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormOrdersForGetPrices extends StatelessWidget {
  final String label_;
  final String hintText_;
  final IconData? icon_;
  final String? Function(String?)? validation; 
  final  TextEditingController? mycontroller;
  final bool isNumber;
  final bool inputFormatters_ ;
  final bool readOnly_;


 final void Function(String)? onChanged_;

 
  

  const CustomTextFormOrdersForGetPrices({
         super.key, 
                      required this.label_, 
                      required this.hintText_,
                      required this.icon_, 
                      this.validation, 
                      this.mycontroller, 
                      required this.isNumber, 
                      required this.inputFormatters_,
                       required this.readOnly_,
                        this.onChanged_,


                     

                     
                      
                      });

  @override
  Widget build(BuildContext context) {


     // Check if the controller has a value, if not, set a default value
    // if (mycontroller != null && mycontroller!.text.isEmpty) {
    //   mycontroller!.text = "0"; // Set default value
    // }
    // else{
    //    mycontroller!.text =  mycontroller!.text;
    // }



    return Container(
       
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0) ,

      child: TextFormField(
                          
                           validator: validation,
                           controller: mycontroller,
                            keyboardType: isNumber ?const TextInputType.numberWithOptions(decimal: true) 
                                     :   TextInputType.text, 

                           inputFormatters: inputFormatters_ == false
                            ? []
                            : [FilteringTextInputFormatter.deny(RegExp('[,/+-]')), // deny to write , / 
                            
                             FilteringTextInputFormatter.allow(
                          //   RegExp(r'^\d+\.?\d{0,2}$'), // allow 2 number after dot
                            //  RegExp(r'^\d*\.?\d{2}$')
                            RegExp(r'(^\d*[.,]?\d{0,2})')
        ),
        FilteringTextInputFormatter.singleLineFormatter
                               ],

                           readOnly: readOnly_ == true ? true : false  ,
                           onChanged: onChanged_,



    
                      decoration:
              
                          InputDecoration(
                          
                          
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                         contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        
                         label: Text(label_),
                         hintText: hintText_,
                         suffixIcon:  Icon(icon_),
                    
                         
                         border:
                           const OutlineInputBorder(borderRadius: BorderRadius.zero,
                           gapPadding: 2.0
      
                         )
                         ),
      ),
    );
   
  }
}