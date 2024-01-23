import 'package:flutter/material.dart';


class CustomHomeGridView extends StatelessWidget {
  final String image;
  final String title;
  final void Function()? onClick;

  const CustomHomeGridView({super.key, required this.image, required this.title, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return     InkWell(
                       onTap: onClick,
     
      child: Container(margin: EdgeInsets.all(5.0),
               
               child: Column(mainAxisSize: MainAxisSize.min,
                children: [
                                  Image.asset(image, height: 90.0,width: 150.0,),
                                  Text(title)
                ],),
                
                ),
    );
  }
}