import 'package:get/get.dart';

import '../models/item.dart';

import '../database/db_helper.dart';

class ItemController extends GetxController {
  @override
  void onReady() {
    getItem();
    super.onReady();
  }

  var itemList = <Item>[].obs;

  Future<int> addItem({Item? item}) async {
    return await DBHelper.insert(item!);
  }

  void getItem() async {
    List<Map<String, dynamic>> items = await DBHelper.query();
    itemList.assignAll(items.map((data) => Item.fromJson(data)).toList());
  }

  void removeItem(Item item) async {
    await DBHelper.delete(item);
    getItem();
  }

  void markItemConsumed(int id) async {
    await DBHelper.update(id);
    getItem();
  }
}
