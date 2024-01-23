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
  int? companyId;
  String? companyName;
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

  double? totalPrice;

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
      this.companyId,
      this.companyName,
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
    companyId = json['company_id'];
    companyName = json['company_name'];

    bottelId = json['bottle_id'];
    bottelName = json['bottle_name'];

    pricePerBottel = json['price_per_bottel'];
    qtyOfBottels = json['qty_of_bottles'];
    totalpriceOfBottels = json['tolal_price_bottel'];

    qtyJarIn = json['qty_jar_in'];
    qtyJarOut = json['qty_jar_out'];
    qtyPreviousJars = json['qty_previous_jars'];

    totalJar = json['total_jar'];
    pricePerJar = json['price_per_jar'];
    totalpriceOfJars = json['total_price_jars'];

    totalPrice = json['total_price'];



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
    data['company_id'] = this.companyId;
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

    data['total_price'] = this.totalPrice;


    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    
    return data;
  }
}








