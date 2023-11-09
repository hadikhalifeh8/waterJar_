import 'package:flutter/material.dart';

class CustomListTileDrivers extends StatelessWidget {
      final String title_;
  final String leading_;
  final void Function()? onEdit;
  final void Function()? onDelete;
  final IconData? iconEdit;
  final IconData? iconDelete;


  const CustomListTileDrivers({super.key, 
  required this.title_,
   required this.leading_,
    required this.onEdit,
    required this.onDelete, 
    required this.iconEdit,
    required  this.iconDelete
      });

  @override
  Widget build(BuildContext context) {
    return     Card(
                          child: ListTile(
                          title: Text(title_),
                          leading: Text(leading_),
                          
                          trailing: Row( 
                             mainAxisSize: MainAxisSize.min,
                            
                            children: [
                            IconButton(onPressed: onEdit,

                            icon:  Icon(iconEdit, color: Colors.blue,)
                            ),


                             IconButton(onPressed: onDelete,
                             
                              icon:  Icon(iconDelete, color: Colors.red,)),
                          ],),
                                              ),
                        );
  }
}