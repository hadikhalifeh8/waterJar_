import 'package:flutter/material.dart';

class CustomListTileBottels extends StatelessWidget {
      final String name_;
  // final String company_;
  final String price_;
  final String leading_;


  final void Function()? onEdit;
  final void Function()? onDelete;
  final IconData? iconDelete;


  const CustomListTileBottels({super.key, 
  required this.name_,
  //  required this.company_,
   required this.price_,

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
                                  
                        //  leading:  Container(padding: const EdgeInsets.only(top: 5.0),child: Text(leading_)),
                        
                         title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                   Container(padding: const EdgeInsets.only(right: 15.0),child: Text(leading_)),
                                    
                                     Container(padding: const EdgeInsets.only(right: 10.0, left: 10),child: Text(name_)),
                        
                                    // Container(padding: const EdgeInsets.only(right: 10.0, left: 10),child: Text(company_)),
                  
                                   Container(padding: const EdgeInsets.only( left: 10),child: Text(price_)),
                  
                        
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