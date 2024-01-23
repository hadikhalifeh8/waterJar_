import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormOrdersPrice extends StatelessWidget {
  final String label_;
  final String hintText_;
  final String? Function(String?)? validation; 
  final TextEditingController? mycontroller;
  final IconData? icon_;
  final void Function()? onTap_;
  final bool isNumber;
//  final bool obscureText_ ;
  final bool inputFormatters_ ;
 // final String? initialValue_;
 final bool readOnly_;
//  final void Function(String?)? onBottelChanged; 




   

  const CustomTextFormOrdersPrice({
    super.key,
     required this.label_, 
     required this.hintText_, 
      this.validation,
     required this.mycontroller, 
     required this.icon_,
     this.onTap_, 
     required this.isNumber, 
   //  required this.obscureText_,
     required this.inputFormatters_,
     // this.initialValue_,
     required this.readOnly_,
      // this.onBottelChanged,



   


      });

  @override
  Widget build(BuildContext context) {

    // Check if the controller has a value, if not, set a default value
     if (mycontroller != null && mycontroller!.text.isEmpty) {
      mycontroller!.text = "0"; // Set default value
    }

    //            // Call the onTownChanged callback when a town is selected
    //   if (onBottelChanged != null && onBottelChanged!.toString().isEmpty) {
    //     // const Text("choose District");
    //      onBottelChanged!(mycontroller!.text);
    //   //  onBottelChanged!("kkk");
        
    // }


    return Container(
      
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0) ,


                 child: 

                  TextFormField(
                   // initialValue: initialValue_,
                  //  cursorWidth: 20.0,
                 //   maxLength: 3,
                    controller: mycontroller ,
                    validator: validation,
                  //  obscureText: obscureText_ == null || obscureText_ == false ? false : true,
                    
              keyboardType: isNumber ?const TextInputType.numberWithOptions(decimal: true) 
                                     :   TextInputType.text, 


            inputFormatters: inputFormatters_ == false
                            ? []
                            : [FilteringTextInputFormatter.deny(RegExp('[,/]')), // deny to write , / 
                             FilteringTextInputFormatter.allow(
                             RegExp(r'^\d+\.?\d{0,2}'), // allow 2 number after dot
        ),
                            
                            ],

          readOnly: readOnly_ == true ? true : false  ,


          


                    decoration:
            
                       InputDecoration(
                        
                        
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                       contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      
                       label: Text(label_),
                       hintText: hintText_,
                       suffixIcon:  InkWell(onTap: onTap_ ,child: Icon(icon_),),
                       
                       border:
                        const OutlineInputBorder(borderRadius: BorderRadius.zero,
                        gapPadding: 6.0
    
                        
                    //   OutlineInputBorder(borderRadius: BorderRadius.all()
                       )
                       ),

      ),
      );
  }
}