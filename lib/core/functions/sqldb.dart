import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb{
  




static Database? _db; // variable  private 

// eza n3amal initial ma bade heye ten3amal marra tanye {bs marra we7de}
  Future<Database?> get db async {
    if (_db == null) { // ma n3amala initial
      _db = await initialDB();
    return _db;

    } else{ // eza n3ammala initial =>kel she tmm
           return _db;
    }
   
   
  }




  initialDB() async{

    String databasePath = await getDatabasesPath(); // e5teyar lmasar
    String path = join(databasePath, 'jar.db'); //'databasePath/eccomerce_app.db' =>rabot esm l db ma3 l path
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade); // b2anshe2 l db;
    // version: eza bade zeed table msh b7aje kel sa3a em7e l db , bs b3adel 3al version
    // wb7ot lonUpgrade
    return mydb;
  }



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

  

     await batch.commit();
     print("=========================== _onCreate");
  }



// eza bade zeed table 3a db / 3adl she ...
_onUpgrade(Database db, int oldVersion, int newVersion)async {


     print("=========================== _onUpgrade");

      // await db.execute(
      //           "ALTER TABLE test ADD COLUMN mobile TEXT");


    //        // إسم الزبون
    //       await  db.execute('''  
    //   CREATE TABLE "customers" (
    //     "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
    //     "name" TEXT NOT NULL UNIQUE,
    //     "phone" TEXT NOT NULL UNIQUE,
    //     "town_id" INTEGER NOT NULL,
    //     "district_id" INTEGER NOT NULL,

    //     "FOREIGN KEY (town_id) REFERENCES towns (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
    //     "FOREIGN KEY (district_id) REFERENCES district (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"

        
    //   )
    //  ''');


//      await db.execute('''
//   CREATE UNIQUE INDEX "unique_phone" ON "drivers" ("phone")
// ''');
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