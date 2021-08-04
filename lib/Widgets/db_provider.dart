import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import '../Models/transactions.dart';

class DbProvider{
  Database? db;
  init() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path,"items.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version){
        newDb.execute(""" 
          CREATE TABLE Items
          (
            id TEXT PRIMARY KEY,
            title TEXT,
            amount BLOB,
            date BLOB
          )
        """
        );
      }
    );
  }
  
  fetchItem(String id) async {
   final maps = await db!.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );
    if(maps.length>0){
      return Transaction.fromDb(maps.first);
    }
    return null; 
  }
}
