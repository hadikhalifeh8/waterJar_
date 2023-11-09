
import 'package:water_jar/core/class/crud.dart';
import 'package:get/get.dart';
import 'package:water_jar/core/functions/sqldb.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies() {
    //Get.lazyPut(() => SignUpControllerImp());
    Get.put(Crud());    //Crud crud  = Crud(); حط  controller بلا ما بكل  
    Get.put(SqlDb());
  }
  

}