import 'package:flutter/material.dart';

class CustomListTileJars extends StatelessWidget {
      final String jarName;
      final String price;

      final String leading_;


  final void Function()? onEdit;
  final void Function()? onDelete;
  final IconData? iconDelete;


  const CustomListTileJars({super.key, 
  required this.jarName,
  required this.price,

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
                        mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(jarName),
                          const SizedBox(width: 80.0,),
                           Text(price),

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