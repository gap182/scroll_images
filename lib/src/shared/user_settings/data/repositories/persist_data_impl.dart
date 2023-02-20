import 'package:hive_flutter/hive_flutter.dart';
import 'package:scroll_images/src/shared/user_settings/domain/repositories/persist_data.dart';

class PersistDataImplementation implements PersistDataRepository {
  @override
  Future<void> init(String id) async {
    await Hive.openBox(id);
  }

  @override
  Future readInfo(String boxId, String id) async {
    try {
      final box = Hive.box(boxId);
      final data = box.get(id);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> writeInfo(String boxId, String key, data) async {
    try {
      final box = Hive.box(boxId);
      box.put(key, data);
    } catch (e) {
      rethrow;
    }
  }
}
