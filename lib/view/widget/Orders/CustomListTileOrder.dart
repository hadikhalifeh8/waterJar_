import 'package:flutter/material.dart';

class CustomListTileOrder extends StatelessWidget {
  final String id;
  final String districtName;
  final String townName; 

 final void Function()? onEdit;
 final void Function()? onDelete;
 //final IconData iconDataEdit;
 final IconData iconDataDelete;




  const CustomListTileOrder({
                        super.key, 
                          required this.id, 
                          required this.districtName, 
                          required this.townName, 
                           
                          //required this.iconDataEdit, 
                          required this.iconDataDelete,

                           this.onEdit,
                           this.onDelete
                         });

  @override
  Widget build(BuildContext context) {
    return  
          InkWell(
            onTap: onEdit,
            child: Card(
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
                  
                       
                         IconButton(onPressed: onDelete, icon: Icon(iconDataDelete, color: Colors.red,)),
                       
                   ),
              
                
              
              ),
          );
  }
}