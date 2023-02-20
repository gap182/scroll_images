abstract class PersistDataRepository {
  Future<void> init(String id);
  Future<void> writeInfo(String box, String key, dynamic data);
  Future<dynamic> readInfo(String box, String key);
}
