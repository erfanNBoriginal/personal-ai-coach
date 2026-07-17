import 'package:url_launcher/url_launcher.dart';

abstract class Launcher {
  static Future<bool> url(String url, {
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: mode);
      return true;
    }
    return false;
  }
}
