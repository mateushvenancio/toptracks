import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toptracks/repositories/i_storage_repository.dart';

class SecureStorageRepository implements IStorageRepository {
  final _storage = const FlutterSecureStorage();

  @override
  Future<String?> loadString(String name) {
    return _storage.read(key: name);
  }

  @override
  Future<void> saveString(String name, String value) async {
    await _storage.write(key: name, value: value);
  }
}
