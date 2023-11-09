import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Orders/addController.dart';

class AddOrder extends StatelessWidget {
  const AddOrder({super.key});

  @override
  Widget build(BuildContext context) {
    AddOrderController controller = Get.put(AddOrderController());
    return Scaffold(appBar:

    AppBar(title: Text("Order"),
    centerTitle: true,
    ),

    body:
    Text("${controller.daysModel!.name.toString()}")
    );
    
  }
}