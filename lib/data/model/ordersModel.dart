class OrdersModel {
  int? id;
  int? dayId;
  String? dayName;
  int? driverId;
  String? driverName;
  int? customerId;
  String? customerName;
  int? townId;
  String? townName;
  int? districtId;
  String? districtName;
  int? jarId;
  String? jarName;
  int? bottelId;
  String? bottelName;
  int? qtyOfBottels;
  double? pricePerBottel;
  double? totalpriceOfBottels;
  int? qtyJarIn;
  int? qtyJarOut;
  int? qtyPreviousJars;
  int? totalJar;
  double? pricePerJar;
  double? totalpriceOfJars;

  String? status;

  double? oldDebt; // ==> ديون سابقه
  double? newDebt; // ==> ديون سابقه


  double? paid; // ==>أدي دفع
  double? totalPrice; // ==> المجموع


  String? createdAt;
  String? updatedAt;


  OrdersModel(
      {this.id,
      this.dayId,
      this.dayName,
      this.driverId,
      this.driverName,
      this.customerId,
      this.customerName,
      this.townId,
      this.townName,
      this.districtId,
      this.districtName,
      this.jarId,
      this.jarName,
      this.bottelId,
      this.bottelName,
      this.pricePerBottel,
      this.qtyOfBottels,
      this.totalpriceOfBottels,
      this.qtyJarIn,
      this.qtyJarOut,
      this.qtyPreviousJars,

      this.totalJar,
      this.pricePerJar,
      this.totalpriceOfJars,

      this.status,


      this.oldDebt,
      this.newDebt,

      this.paid,
      this.totalPrice,




      this.createdAt,
      this.updatedAt,
      });

  OrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayId = json['day_id'];
    dayName = json['day_name'];
    driverId = json['driver_id'];
    driverName = json['driver_name'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    townId = json['town_id'];
    townName = json['town_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    jarId = json['jar_id'] != null ? int.tryParse(json['jar_id'].toString()) : null;
    jarName = json['jar_name'];

    bottelId = json['bottle_id'] != null ? int.tryParse(json['bottle_id'].toString()) : null;
    // bottelId = json['bottle_id'];
    bottelName = json['bottle_name'];

    
    pricePerBottel = json['price_per_bottel'] != null ? double.tryParse(json['price_per_bottel'].toString()) : null;
    qtyOfBottels =  json['qty_of_bottles'] != null ? int.tryParse(json['qty_of_bottles'].toString()) : null;
    totalpriceOfBottels = json['tolal_price_bottel'] != null ? double.tryParse(json['tolal_price_bottel'].toString()) : null;

    qtyJarIn = json['qty_jar_in'] != null ? int.tryParse(json['qty_jar_in'].toString()) : null;
    qtyJarOut = json['qty_jar_out'] != null ? int.tryParse(json['qty_jar_out'].toString()) : null;
    qtyPreviousJars = json['qty_previous_jars'] != null ? int.tryParse(json['qty_previous_jars'].toString()) : null;

    totalJar = json['total_jar'] != null ? int.tryParse(json['total_jar'].toString()) : null;
    pricePerJar = json['price_per_jar'] != null ? double.tryParse(json['price_per_jar'].toString()) : null;
    totalpriceOfJars = json['total_price_jars'] != null ? double.tryParse(json['total_price_jars'].toString()) : null;


    
    oldDebt = json['old_debt'] != null ? double.tryParse(json['old_debt'].toString()) : null;
    newDebt = json['new_debt'] != null ? double.tryParse(json['new_debt'].toString()) : null;

    paid = json['paid'] != null ? double.tryParse(json['paid'].toString()) : null;
    totalPrice = json['total_price'] != null ? double.tryParse(json['total_price'].toString()) : null;
   




    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day_id'] = this.dayId;
    data['driver_id'] = this.driverId;
    data['customer_id'] = this.customerId;

    data['town_id'] = this.townId;
    data['district_id'] = this.districtId;
    data['jar_id'] = this.jarId;
    data['bottle_id'] = this.bottelId;
    data['price_per_bottel'] = this.pricePerBottel;
    data['qty_of_bottles'] = this.qtyOfBottels;
    data['tolal_price_bottel'] = this.totalpriceOfBottels;
    data['qty_jar_in'] = this.qtyJarIn;
    data['qty_jar_out'] = this.qtyJarOut;
    data['qty_previous_jars'] = this.qtyPreviousJars;
    data['total_jar'] = this.totalJar;
    data['price_per_jar'] = this.pricePerJar;
    data['total_price_jars'] = this.totalpriceOfJars;

    data['status'] = this.status;


    data['old_debt'] = this.oldDebt;
    data['new_debt'] = this.newDebt;

    data['paid'] = this.paid;
    data['total_price'] = this.totalPrice;



    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    
    return data;
  }
}








