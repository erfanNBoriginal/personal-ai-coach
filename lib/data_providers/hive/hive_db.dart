import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_ai_coach/tool_kit/utils.dart';

abstract class HiveDB {
  static const _secureStorage = FlutterSecureStorage();

  static Future<List<int>> getEnc() async {
    final deviceId = await Utils.getDeviceUid();
    final existing = await _secureStorage.read(key: deviceId);

    if (existing == null) {
      return await setEnc();
    }
    return base64Decode(existing);
  }

  static Future<List<int>> setEnc() async {
    final secKey = Hive.generateSecureKey();
    final deviceId = await Utils.getDeviceUid();
    await _secureStorage.write(key: deviceId, value: base64Encode(secKey));
    return secKey;
  }

  static Future<void> init({required String appName}) async {
    if (kIsWeb) {
      Hive.init('');
    } else {
      final docDir = await getApplicationDocumentsDirectory();
      final appDir = await Directory('${docDir.path}/$appName').create();
      Hive.init(appDir.path);
    }
  }

  static Future<void> openBox({required String boxName}) async {
    await Hive.openBox(
      boxName,
      crashRecovery: true,
      encryptionCipher: HiveAesCipher(await getEnc()),
    );
  }

  static dynamic get({required String boxName, required String key}) {
    if (!Hive.isBoxOpen(boxName)) {
      throw '$boxName not found';
    }
    final res = Hive.box(boxName).get(key);
    return res;
  }

  static Future<void> set<T>({
    required String boxName,
    required String key,
    required T value,
  }) async {
    if (!Hive.isBoxOpen(boxName)) {
      throw '$boxName not found. Open the Box!';
    }
    await Hive.box(boxName).put(key, value);
  }
}
