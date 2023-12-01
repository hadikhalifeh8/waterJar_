import 'package:flutter/material.dart';

class CustomListTileCompany extends StatelessWidget {
      final String companyName;
      final String leading_;


  final void Function()? onEdit;
  final void Function()? onDelete;
  final IconData? iconDelete;


  const CustomListTileCompany({super.key, 
  required this.companyName,
   required this.leading_,
  required this.onEdit,
  required this.onDelete, 
  required  this.iconDelete
      });

  @override
  Widget build(BuildContext context) {
    return     InkWell(
                    onTap: onEdit,
      
      
        child: Card(
                  child: ListTile(
                                
                       leading: Container(padding: const EdgeInsets.only(top: 5.0),child: Text(leading_)),
      
                       title: Text(companyName),
      
                              
                              
                        trailing: 
                                 IconButton(onPressed: onDelete,
                                  icon:  Icon(iconDelete, color: Colors.red,)
                                  ),
                              
                                                  ),
                            ),
      
    );
  }
}