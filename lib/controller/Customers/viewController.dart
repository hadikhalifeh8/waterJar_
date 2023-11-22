import 'package:get/get.dart';
import 'package:water_jar/core/class/statusRequest.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/functions/handlingDataController.dart';
import 'package:water_jar/core/functions/sqldb.dart';
import 'package:water_jar/data/model/customersModel.dart';

class ViewCustomerController extends GetxController {


SqlDb sqlDb = SqlDb();
List<CustomersModel> customers = [];
StatusRequest statusRequest = StatusRequest.none;




  Future readDatas() async{
    customers.clear(); // for delete refresh
     update();
    statusRequest = StatusRequest.loading;
   

    // List<Map> response = await sqlDb.readData("SELECT * FROM district WHERE id = ");
    List<Map> response = await sqlDb.readData('''
  SELECT customers.id, customers.name, customers.phone, customers.town_id, customers.district_id,
         towns.id as town_id, towns.name as town_name,
         district.id as district_id, district.name as district_name, district.town_id as town_id

  FROM customers
  JOIN towns ON customers.town_id = towns.id
  JOIN district ON customers.district_id =  district.id

        ''');

      print("***************##############************* Controler $response ");


           statusRequest = handlingData(response);
           if(StatusRequest.success == statusRequest)
           {
             if(response.length > 0)
             {
                    List listDistrict  = response;
            
            customers.addAll(listDistrict.map((e) => CustomersModel.fromJson(e)));
                     
                     update();
                      print("yes has Customers data");
                        return response;
             }else{
               print("No data");
               update();
   
    return  statusRequest = StatusRequest.failure;

             }
            
           }
            update();    
  }

  goToaddPage()
  {
    Get.toNamed(AppRoute.customeradd);
  }


  goToEditPage(CustomersModel customersModel)
  {
    Get.toNamed(AppRoute.customeredit, 
                   arguments: {
                    "customersModel_" : customersModel,
                   }
                      );
  }

  @override
  void onInit() {

    update();
    readDatas();
    print("This is Custommerssss Details");
    super.onInit();
  }



}