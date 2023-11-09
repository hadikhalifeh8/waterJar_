import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String id;
  final String districtName;
  final String townName; 

 final void Function()? onEdit;
 final void Function()? onDelete;
 final IconData iconDataEdit;
 final IconData iconDataDelete;




  const CustomListTile({
                        super.key, 
                          required this.id, 
                          required this.districtName, 
                          required this.townName, 
                           
                          required this.iconDataEdit, 
                          required this.iconDataDelete,

                          required this.onEdit,
                          required this.onDelete
                         });

  @override
  Widget build(BuildContext context) {
    return  
    Card(
              child: ListTile(
               
                leading: Text(id,textAlign: TextAlign.start,),
                 
                 title: Row(
                              mainAxisSize: MainAxisSize.min,
                   children: [
                              Text(districtName,textAlign: TextAlign.start),
                         const Spacer(),
                              Text(townName,textAlign: TextAlign.start),
                   ],
                 ),
            
                 trailing: 
                    Row(
                    mainAxisSize: MainAxisSize.min,
                  //  crossAxisAlignment: CrossAxisAlignment.end,


                     children: [
                       IconButton(onPressed: onEdit, icon: Icon(iconDataEdit, color: Colors.blue,)),
                     
                       IconButton(onPressed: onDelete, icon: Icon(iconDataDelete, color: Colors.red,)),
                     ],
                   ),
                 ),
            
              
            
    );
  }
}