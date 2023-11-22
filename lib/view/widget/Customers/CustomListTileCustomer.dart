import 'package:flutter/material.dart';

class CustomListTileCustomers extends StatelessWidget {
      final String town_;
  final String district_;
  final String leading_;


  final void Function()? onEdit;
  final void Function()? onDelete;
  final IconData? iconDelete;


  const CustomListTileCustomers({super.key, 
  required this.town_,
   required this.district_,
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
      
                       title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(flex: 2,child: Text(town_)),
      
                                  Expanded(flex: 2,child: Text(district_)),
      
                                ],
                              ),
                              
                              
                        trailing: 
                                 IconButton(onPressed: onDelete,
                                  icon:  Icon(iconDelete, color: Colors.red,)
                                  ),
                              
                                                  ),
                            ),
      
    );
  }
}