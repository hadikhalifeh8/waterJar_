import 'package:get/get.dart';
import 'package:water_jar/controller/Days/addController.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/daysModel.dart';
import 'package:water_jar/data/model/driversModel.dart';

class ViewDaysController extends GetxController {
  SqlDb sqlDb = SqlDb();
  List<DaysModel> day =[];
  List<DriversModel> driver =[];


  bool loading =false;


  Future getDaysData() async {
  loading == true;
    List<Map> response = await sqlDb.readData("SELECT * FROM days");

    // day.addAll(response); ==> DaysModel? daysModel;

    List listdays = response;
    day.addAll(listdays.map((e) => DaysModel.fromJson(e)));
    
      update();

     return response;

  }


    Future getDriversData() async {
  loading == true;
    List<Map> response = await sqlDb.readData("SELECT * FROM drivers");

    // day.addAll(response); ==> DaysModel? daysModel;

    List listdays = response;
    driver.addAll(listdays.map((e) => DriversModel.fromJson(e)));
    
      update();

     return response;

  }

  goToOrderPage(DaysModel daysModel)
  {
    Get.toNamed(AppRoute.orderadd, arguments: {

      'daysModel_' : daysModel,
      

    

    });
print("lklk");
  }


    //  AddDaysController addcontroller = Get.put(AddDaysController());


  @override
  void onInit() {
    
   getDaysData();
   getDriversData();

    super.onInit();
  }
}