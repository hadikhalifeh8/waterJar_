import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:water_jar/core/constant/routes.dart';
import 'package:water_jar/core/middleware/myMiddleware.dart';
import 'package:water_jar/view/screen/Customers/add.dart';
import 'package:water_jar/view/screen/Districts/add.dart';
import 'package:water_jar/view/screen/Districts/edit.dart';
import 'package:water_jar/view/screen/Districts/view.dart';
import 'package:water_jar/view/screen/Drivers/add.dart';

import 'package:water_jar/view/screen/Drivers/edit.dart';
import 'package:water_jar/view/screen/Drivers/view.dart';
import 'package:water_jar/view/screen/Order/add.dart';
import 'package:water_jar/view/screen/Towns/add.dart';

import 'package:water_jar/view/screen/Towns/view.dart';
import 'package:water_jar/view/screen/test1.dart';



List<GetPage<dynamic>>? routes = [

   GetPage(name:  "/", page: () => const AddCustomer(), middlewares: [MyMidlleware()]),
    GetPage(name:  AppRoute.test1, page: () => const Test1(),),

    GetPage(name:  AppRoute.orderadd, page: () => const AddOrder(),),
    
    // DRIVERS
    GetPage(name:  AppRoute.driveradd, page: () => const AddDriver(),),
    GetPage(name:  AppRoute.driversview, page: () => const ViewDrivers(),),
    GetPage(name:  AppRoute.driveredit, page: () => const EditDriver(),),


    // TOWNS
    GetPage(name:  AppRoute.townadd, page: () => const AddTown(),),
    GetPage(name:  AppRoute.townview, page: () => const ViewTowns(),),
    

    // Districts
    GetPage(name:  AppRoute.districtadd, page: () => const AddDistrict(),),
    GetPage(name:  AppRoute.districtedit, page: () => const EditDistrict(),),
    GetPage(name:  AppRoute.districtview, page: () => const ViewDistreicts(),),

    
    // Customers
    GetPage(name:  AppRoute.customeradd, page: () => const AddCustomer(),),
    




















];



