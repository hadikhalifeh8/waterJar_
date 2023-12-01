import 'package:flutter/material.dart';

class CustomListTileDrivers extends StatelessWidget {
      final String title_;
  final String leading_;
  final void Function()? onEdit;
  final void Function()? onDelete;
 // final IconData? iconEdit;
  final IconData? iconDelete;


  const CustomListTileDrivers({super.key, 
  required this.title_,
   required this.leading_,
    required this.onEdit,
    required this.onDelete, 
    //required this.iconEdit,
    required  this.iconDelete
      });

  @override
  Widget build(BuildContext context) {
    return     InkWell(
      onTap: onEdit,
      child: Card(
                            child: ListTile(
                            title: Text(title_),
                            leading: (Container(padding: EdgeInsets.only(top:4),child: Text(leading_))),
                            
                            trailing: 
    
    
                               IconButton(onPressed: onDelete,
                               
                                icon:  Icon(iconDelete, color: Colors.red,)),
                            
                                                ),
                          ),
    );
  }
}