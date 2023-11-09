import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomNameOfDays extends StatelessWidget {
  final void Function()? onTap_;
  final SvgPicture? svgPicture_; 
  const CustomNameOfDays({super.key, required this.onTap_, required this.svgPicture_});

  @override
  Widget build(BuildContext context) {
    return    InkWell(
                        onTap:  onTap_ ,

                        child: Container(
                          
                          padding: const EdgeInsets.all(15.0),width: 10, height: 15.0,
                        
                         child: 

                          //  SvgPicture.asset(AppImageAsset.monday),
                          svgPicture_

                    
                    ),
                      );
  }
}