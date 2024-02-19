import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb{
  




static  Database? _db; // variable  private 

// eza n3amal initial ma bade heye ten3amal marra tanye {bs marra we7de}
  Future<Database?> get db async {
    if (_db == null) { // ma n3amala initial
      _db = await initialDB();
    return _db;

    } else{ // eza n3ammala initial =>kel she tmm
           return _db;
    }
   
   
  }
Future<Database?> initialDB() async {
  try {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'jar.db');
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  } catch (e) {
    print('Error initializing database: $e');
    return null;
  }
}



  // initialDB() async{

  //   String databasePath = await getDatabasesPath(); // e5teyar lmasar
  //   String path = join(databasePath, 'jar.db'); //'databasePath/eccomerce_app.db' =>rabot esm l db ma3 l path
  //   Database mydb = await openDatabase(path, onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade); // b2anshe2 l db;
  //   // version: eza bade zeed table msh b7aje kel sa3a em7e l db , bs b3adel 3al version
  //   // wb7ot lonUpgrade
  //   return mydb;
  // }



// eza bade zeed column men hon(_onCreate) bade em7e ldb(myDeleteDataBase) wberja3 bcreata 
//** ORRR */
// bsta3mel (_onUpgrade) 1- b8ayer ra2om l version / 2- b3mel alter lal table

  _onCreate(Database db, int version) async
  {
    Batch batch = db.batch();
    //  await db.execute('''  // => to insert one table / Batch => to insert many tables
  
   batch.execute('''  
      CREATE TABLE "days" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "name" TEXT NOT NULL,
        "image" TEXT NOT NULL
      )
     ''');


        batch.execute('''  
      CREATE TABLE "drivers" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
        "name" TEXT NOT NULL UNIQUE,
        "phone" TEXT NOT NULL UNIQUE,
        "password" TEXT NOT NULL
      )
     ''');


           //  إسم البلده
           batch.execute('''  
      CREATE TABLE "towns" ( 
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
        "name" TEXT NOT NULL UNIQUE
       
        
        
      )
     ''');


                // إسم الحي
          batch.execute('''  
      CREATE TABLE "district" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
        "name" TEXT NOT NULL UNIQUE,
        "town_id" INTEGER NOT NULL, 
        "FOREIGN KEY (town_id) REFERENCES towns (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
        
      )
     ''');


                // إسم الزبون
          batch.execute('''  
      CREATE TABLE "customers" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
        "name" TEXT NOT NULL UNIQUE,
        "phone" TEXT NOT NULL UNIQUE,
        "town_id" INTEGER NOT NULL,
        "district_id" INTEGER NOT NULL,

        "FOREIGN KEY (town_id) REFERENCES towns (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
        "FOREIGN KEY (district_id) REFERENCES district (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"

      )
     ''');


       //  إسم البلده
           batch.execute('''  
      CREATE TABLE "company" ( 
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
        "name" TEXT NOT NULL UNIQUE
        
      )
     ''');

              // أنواع جرار المياه
          batch.execute('''  
      CREATE TABLE "jars" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
        "name" TEXT NOT NULL UNIQUE,
        "price" FLOAT BY DEFAULT "0" NOT NULL
      )
     ''');

         // أنواع جرار المياه
          batch.execute('''  
      CREATE TABLE "bottels" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
        "name" TEXT NOT NULL UNIQUE,
        "price" FLOAT BY DEFAULT "0" NOT NULL
       
      )
     ''');

                     // الأدمن
            batch.execute('''  
      CREATE TABLE "admin" ( 
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
        "name" TEXT NOT NULL UNIQUE,
         "phone" TEXT NOT NULL UNIQUE,
         "password" TEXT NOT NULL,
         "status" INTEGER BY DEFAULT "0" NOT NULL 
        
      )
     ''');


                 // الفاتوره
          batch.execute('''  
      CREATE TABLE "orders" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
        "day_id" INTEGER NOT NULL,
        "driver_id" INTEGER NOT NULL,
        "customer_id" INTEGER NOT NULL,
        "town_id" INTEGER NOT NULL,
        "district_id" INTEGER NOT NULL,
         
        "jar_id" INTEGER NULL REFERENCES jars (id),
        "bottle_id" INTEGER NULL REFERENCES bottels (id) ,
        
        "qty_of_bottles" INTEGER DEFAULT 0,
        "price_per_bottel" FLOAT DEFAULT 0.0,
        "tolal_price_bottel" FLOAT DEFAULT 0.0,

        "qty_jar_in" INTEGER DEFAULT 0,
        "qty_jar_out" INTEGER DEFAULT 0,
        "qty_previous_jars" INTEGER  DEFAULT 0,

        "total_jar" INTEGER DEFAULT 0,


        "price_per_jar" FLOAT DEFAULT 0.0,
        "total_price_jars" FLOAT DEFAULT 0.0,
       
        


        "old_debt" FLOAT DEFAULT 0.0,
        "new_debt" FLOAT DEFAULT 0.0,

        "paid" FLOAT DEFAULT 0.0,
        "total_price" FLOAT DEFAULT 0.0,


         "FOREIGN KEY (day_id) REFERENCES days (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
         "FOREIGN KEY (driver_id) REFERENCES drivers (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
         "FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
         "FOREIGN KEY (town_id) REFERENCES towns (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
         "FOREIGN KEY (district_id) REFERENCES district (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
        
      )
     ''');

    //    batch.execute('''
    //                UPDATE orders set jar_id=0 WHERE jar_id IS NULL;

    //  ''');

//"status"  TEXT , =>0 for bottels / 1 for jars
// debt => ديون
// paid => أدي فع
// total price => المجموع
  

     await batch.commit();
     print("=========================== _onCreate");
  }



// eza bade zeed table 3a db / 3adl she ...
_onUpgrade(Database db, int oldVersion, int newVersion)async {


     print("=========================== _onUpgrade");



    //             //  إسم البلده
    //        await db.execute('''  
    //   CREATE TABLE "admin" ( 
    //     "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
    //     "name" TEXT NOT NULL UNIQUE,
    //      "phone" TEXT NOT NULL UNIQUE,
    //      "password" TEXT NOT NULL
        
    //   )
    //  ''');
           await db.execute('''
                   UPDATE orders set jar_id=0 WHERE jar_id IS NULL;

     ''');

      // await db.execute(
      //           "ALTER TABLE bottels ADD COLUMN status TEXT");


    //        // أنواع جرار المياه
    //       await  db.execute('''  
    //   CREATE TABLE "bottels" (
    //     "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
    //     "name" TEXT NOT NULL UNIQUE,
    //     "company_id" INTEGER NOT NULL,
    //     "price" FLOAT BY DEFAULT "0" NOT NULL,

    //      "FOREIGN KEY (company_id) REFERENCES company (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
    //   )
    //  ''');


//      await db.execute('''
//   CREATE UNIQUE INDEX "unique_phone" ON "drivers" ("phone")
// ''');



    //         // الفاتوره
    //       await  db.execute('''  
    //   CREATE TABLE "orders" (
    //     "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
    //     "day_id" INTEGER NOT NULL,
    //     "driver_id" INTEGER NOT NULL,
    //     "customer_id" INTEGER NOT NULL,
    //     "town_id" INTEGER NOT NULL,
    //     "district_id" INTEGER NOT NULL,
    //     "company_id" INTEGER NOT NULL,
    //     "bottle_id" INTEGER NOT NULL,
    //     "qty_of_bottles" INTEGER BY DEFAULT "0" NOT NULL,
    //     "price" FLOAT BY DEFAULT "0" NOT NULL,
    //     "qty_jar_in" INTEGER BY DEFAULT "0" NOT NULL,
    //     "qty_jar_out" INTEGER BY DEFAULT "0" NOT NULL,
    //     "total_jar" INTEGER BY DEFAULT "0" NOT NULL,
    //     "total_price" FLOAT BY DEFAULT "0" NOT NULL,





    //      "FOREIGN KEY (day_id) REFERENCES days (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
    //      "FOREIGN KEY (driver_id) REFERENCES drivers (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
    //      "FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
    //      "FOREIGN KEY (town_id) REFERENCES towns (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
    //      "FOREIGN KEY (district_id) REFERENCES district (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
    //      "FOREIGN KEY (company_id) REFERENCES company (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
    //      "FOREIGN KEY (bottle_id) REFERENCES bottels (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
    //   )
    //  ''');
}






/***////////////////////////////////raed insert update delete///////////////////////////////////////// */
  readData(String sql)async {
    Database? mydb = await db; // bet7a2a2 eza kan 3aml initial or no
  
    List<Map> response = await mydb!.rawQuery(sql); // 3ashan rawQuery heye men noo3 (Future) bzeed awit
    return response;
  }


  
  insertData(String sql)async {
    Database? mydb = await db; // bet7a2a2 eza kan 3aml initial or no
  
  
    int response = await mydb!.rawInsert(sql); // 3ashan rawInsert heye men noo3 (Future) bzeed awit
    return response;
  }


    updateData(String sql)async {
    Database? mydb = await db; // bet7a2a2 eza kan 3aml initial or no
  
    int response = await mydb!.rawUpdate(sql); // 3ashan rawInsert heye men noo3 (Future) bzeed awit
    return response;
  }


    deleteData(String sql)async {
    Database? mydb = await db; // bet7a2a2 eza kan 3aml initial or no
  
    int response = await mydb!.rawDelete(sql); // 3ashan rawInsert heye men noo3 (Future) bzeed awit
    return response;
  }

// eza bade em7e ldb 

myDeleteDataBase() async {

  String databasePath = await getDatabasesPath(); // e5teyar lmasar
  String path = join(databasePath, 'jar.db'); //'databasePath/eccomerce_app.db' =>rabot esm l db ma3 l path
  await deleteDatabase(path);
}







  // Select
  // Insert  => return int => ra2om l row le zado {1,2, ...} / Or {0} if failed
  // Update  => return int => ra2om l row le update {1,2, ...} / Or {0} if failed
  // Delete  => return int => ra2om l row le delete {1,2, ...} / Or {0} if failed

}