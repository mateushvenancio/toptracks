abstract class IStorageRepository {
  Future<void> saveString(String name, String value);
  Future<String?> loadString(String name);
}
