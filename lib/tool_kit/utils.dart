import 'package:unique_device_identifier/unique_device_identifier.dart';

abstract class Utils {

   static Future<String> getDeviceUid() async {
    return (await UniqueDeviceIdentifier.getUniqueIdentifier())!;
  }
}