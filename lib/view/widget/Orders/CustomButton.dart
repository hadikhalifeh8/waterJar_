import 'package:flutter/material.dart';

class CustomButtonOrder extends StatelessWidget {
  final void Function()? onPressed_;
  final String text_;
  const CustomButtonOrder({super.key, required this.onPressed_, required this.text_});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
        
         child: MaterialButton(onPressed: onPressed_,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
         color: Colors.blue.shade400,
         child:  Text(text_, style: const TextStyle(color: Colors.white),),
         ),
       );
  }
}