import 'package:get/get.dart';
import 'package:water_jar/controller/Days/viewController.dart';
import 'package:water_jar/core/constant/imageasset.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/daysModel.dart';


class AddDaysController extends GetxController {


 SqlDb sqlDb = SqlDb();
 List<DaysModel> day = [];

      insertData() async {
        int response = await sqlDb.insertData
                 
                 ('''
                
                  INSERT INTO 'days' ('name', 'image')
                  VALUES ("MonDay", "${AppImageAsset.monday}"),
                           ("TuesDay", "${AppImageAsset.tuesday}"),
                           ("Wednesday", "${AppImageAsset.wednesday}"),
                           ("Thursday", "${AppImageAsset.thursday}"),
                           ("Friday", "${AppImageAsset.friday}"),
                           ("Saturday", "${AppImageAsset.saturday}")


               
                ''');  

                if(response > 0) {
                  
                  ViewDaysController controller = Get.put(ViewDaysController());
                  controller.getDaysData();
                  
                  Get.offAllNamed(AppRoute.viewdays);
                }
               
                
                print("response add yesss ========**////============");
                print("$response");
      }

      @override
  void onInit() {
    
    super.onInit();
  }



}