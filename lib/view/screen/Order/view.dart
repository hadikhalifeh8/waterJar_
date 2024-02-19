import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_jar/controller/Orders/viewController.dart';
import 'package:water_jar/core/class/handlingDataView.dart';
import 'package:water_jar/data/model/ordersModel.dart';
import 'package:water_jar/view/widget/Orders/CustomListTileOrder.dart';


class ViewOrdersByDrivers extends StatelessWidget {
  
  const ViewOrdersByDrivers({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Get.lazyPut(() =>ViewOrdersController());
    

  
 

   return Scaffold(
  body: GetBuilder<ViewOrdersController>(
    builder: (controller) => Scaffold(
      appBar: AppBar(
        title: controller.isSearch
            ? Container(
                height: 40.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextField(
                  focusNode: controller.focusNode,
                  controller: controller.search,
                  onChanged: controller.onSearchChanged,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 28, 16, 12),
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      hintText: "Search..."),
                ))
            : const Text("View All Orders"),
        centerTitle: true,
        actions: [
          IconButton(
                onPressed: () {
                  controller.onSearchFunc();
                  controller.focusNode.requestFocus();
                 
                },
                icon: Icon(controller.isSearch ? Icons.close : Icons.search)),
              
       
        ],
      ),

      body: HandlingDataView(
        statusRequest: controller.statusRequest,

        widget: 
        ListView(
          children: [
            Stack(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) => CustomListTileOrder(
                    id: controller.orders[index].id.toString(),
                    districtName: controller.orders[index].customerName.toString(),
                    townName: controller.orders[index].totalPrice.toString(),
                    iconDataDelete: Icons.delete_forever_rounded,
                    onEdit: () {
                      controller.goToEditOrderPage(controller.orders[index]);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  )
  );

  }
}
