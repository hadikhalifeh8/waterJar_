import 'package:flutter/material.dart';

class CustomTextFormTown extends StatelessWidget {
  final String label_;
  final String hintText_;
  final String? Function(String?)? validation; 
  final  TextEditingController? mycontroller;
  final IconData? icon_;
  final void Function()? onTap_;
  final bool isNumber;
  // final bool obscureText_ ;
   

  const CustomTextFormTown({
    super.key,
     required this.label_, 
     required this.hintText_, 
     required  this.validation,
     required  this.mycontroller, 
     required this.icon_,
      this.onTap_, 
     required this.isNumber, 
     //required this.obscureText_,

      });

  @override
  Widget build(BuildContext context) {
    return       Container(
        margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                 child: 

                  TextFormField(
                    controller: mycontroller,
                    validator: validation,
                   // obscureText: obscureText_ == null || obscureText_ == false ? false : true,
                    
              keyboardType: isNumber ?const TextInputType.numberWithOptions(decimal: true) 
                                     :   TextInputType.text, 
 

                    decoration:
                       InputDecoration(
                        
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                       contentPadding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                      
                       label: Text(label_),
                       hintText: hintText_,
                       suffixIcon: InkWell(onTap: onTap_ ,child: Icon(icon_)),
                       
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))
                       ),
      ),
      );
  }
}