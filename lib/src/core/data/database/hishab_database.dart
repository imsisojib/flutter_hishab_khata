import 'package:sqflite/sqflite.dart';

class HishabDatabase{

  //db
  final String dbName = "hishab_db";
  //tables
  final String customerTable = "customers";
  final String ordersTable = "orders";

  Database? database;

  Future<void> init() async{
    String databasePath = await getDatabasesPath();

    await openDatabase(
        "$databasePath/$dbName",
        version: 1,
        onCreate: (db,version) async{
          var customerTableCreateSQL = "CREATE TABLE $customerTable (phone_number VARCHAR(11) PRIMARY KEY, name TEXT, address TEXT, company_name TEXT)";
          var ordersTableCreateSQL = "CREATE TABLE $ordersTable (id INTEGER PRIMARY KEY AUTOINCREMENT, total REAL, paid REAL, discount REAL, due REAL, phone_number VARCHAR, FOREIGN KEY(phone_number) REFERENCES $customerTable(phone_number))";

          await db.execute(customerTableCreateSQL);
          await db.execute(ordersTableCreateSQL);
          database = db;
        },
        onOpen: (db){
          database = db;
        },

        onUpgrade: (db,oldeVersion,newVersion){
          database = db;
        },

        onConfigure: _onConfigure,
    );

  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

}