import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Districts/viewController.dart';

class CustomTitlesOFNames extends GetView<ViewDistreictsController> {
  const CustomTitlesOFNames({super.key});

  @override
  Widget build(BuildContext context) {
    return           Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  ...List.generate(controller.listOfTitles.length, (index) => 
                   
                   
                 Expanded(
                        flex: 2,
                         child: Container(
                          
                          margin: const EdgeInsets.only(top: 5.0, ),
                                     
                                     alignment: Alignment.center,
                                     padding: const EdgeInsets.only(bottom: 5.0),
                                     height: 60.0 , width: 80.0,
                                     
                                    decoration: const BoxDecoration(border: BorderDirectional(end: BorderSide(width: 2.0,color: Colors.red), ),
                                   
                                    ),
                                  
                                 child: Text(controller.listOfTitles[index]['Name'],),
                               ),
                       ),
                   ),
                 
                  
                  ],
          );
  }
}