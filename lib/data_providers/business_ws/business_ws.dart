import 'package:personal_ai_coach/data_providers/business_ws/business_client.dart';
import 'package:personal_ai_coach/data_providers/business_ws/business_urls.dart';

abstract class BusinessWs {
  static late BusinessClient client;
  static late BusinessUrls urls;
  static late BusinessServers servers;

  // ignore: non_constant_identifier_names
  static void Init({
    String? customBaseUrl,
    Function(String message)? onError,
    Function()? onUnauthorized,
  }) {
    urls = BusinessUrls();
    servers = BusinessServers();
    client = BusinessClient(
      baseUrl: customBaseUrl ?? servers.current,
      onError: onError ?? (message) {},
      onUnauthorized: onUnauthorized ?? () {},
    );
  }
}
