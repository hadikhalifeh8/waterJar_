import 'package:flutter/material.dart';
import 'package:water_jar/core/constant/imageasset.dart';

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,    
        ),

        body: ListView(children: [
          GridView(
            
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: 130.0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,

            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),


            children: [
              Container(child: 
              Column(children: [
                Image.asset(AppImageAsset.bottel)
              ],),
              
              ),
            ],
          
          
          )
        ],),
    );
  }
}