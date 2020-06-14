import 'dart:io';

import 'package:kulina_submission_test/constant/constant.dart';
import 'package:kulina_submission_test/models/cart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

class LocalStorage {
  Future<sql.Database> openDatabase() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      await dir.create(recursive: true);

      String dbPath = join(dir.path, "personal_lifeDb.db");
      return await sql.openDatabase(
        dbPath,
        onCreate: (db, version) async {
          try {
            await db.execute('''
                CREATE TABLE [cart_item] (
                [id] INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
                [ordered_item_id] INTEGER  NOT NULL,
                [quantity] INTEGER  NOT NULL);''');

            print("Init db Success");
          } catch (e) {
            print(e);
            throw Exception(e);
          }
        },
        version: DATABASE_VERSION,
      );
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<int> addProductToCart(int productId) async {
    try {
      final sql.Database db = await openDatabase();
      final Cart item = await fetchSingleCartContent(productId);
      if (item != null) return null;

      final int resp = await db.insert('cart_item', {
        "ordered_item_id": productId,
        "quantity": 1,
      });

      return resp;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<List<Cart>> fetchCartContent() async {
    try {
      final sql.Database db = await openDatabase();
      final List<Map<String, dynamic>> cartItems = await db.query('cart_item');
      final List<Cart> carts = [];
      cartItems.forEach((element) {
        carts.add(Cart.fromJson(element));
      });

      return carts;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<Cart> fetchSingleCartContent(int itemId) async {
    try {
      final sql.Database db = await openDatabase();
      final List<Map<String, dynamic>> items = await db.query(
        'cart_item',
        where: "ordered_item_id = ?",
        whereArgs: [itemId],
      );

      return items.length > 0 ? Cart.fromJson(items.first) : null;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<int> cleanCartContent() async {
    try {
      final sql.Database db = await openDatabase();
      final int deletedItems = await db.delete('cart_item');

      return deletedItems;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<int> addQuantity(Cart update) async {
    try {
      final sql.Database db = await openDatabase();
      int quantity = update.quantity;
      final int updatedItem = await db.update(
        'cart_item',
        {"quantity": ++quantity},
        where: "ordered_item_id = ?",
        whereArgs: [update.orderedItemId],
      );

      return updatedItem;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> subtractQuantity(Cart update) async {
    try {
      final sql.Database db = await openDatabase();
      int quantity = update.quantity;
      int updatedItem;
      List<Map<String, dynamic>> newItemList = [];
      quantity -= 1;

      if (quantity <= 0) {
        await db.delete('cart_item',
            where: "ordered_item_id = ?", whereArgs: [update.orderedItemId]);
        newItemList = await db.query('cart_item');

        return {"quantity": newItemList.length, "status": "delete"};
      } else {
        updatedItem = await db.update(
          'cart_item',
          {"quantity": quantity},
          where: "ordered_item_id = ?",
          whereArgs: [update.orderedItemId],
        );

        return {"updated": updatedItem, "status": "update"};
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
