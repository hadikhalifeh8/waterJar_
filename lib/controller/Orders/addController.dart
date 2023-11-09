import 'package:get/get.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/daysModel.dart';

class AddOrderController extends GetxController {

 SqlDb sqlDb = SqlDb();
 List<DaysModel> day = [];

DaysModel? daysModel;


  @override
  void onInit() {
   daysModel = Get.arguments['daysModel_'];
    super.onInit();
  }

}