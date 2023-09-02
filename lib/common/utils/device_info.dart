import 'package:flutter/foundation.dart';
import 'package:universal_html/js.dart' as js;
import '../../messages.g.dart';

class DeviceInfoService {
  static Future<String> getDeviceModel() async {
    DeviceInfo deviceInfo = DeviceInfo();
    if (!kIsWeb) {
      final deviceInfoApi = DeviceInfoApi();
      deviceInfo = await deviceInfoApi.getDeviceInfo();
    }

    return switch (kIsWeb) {
      (true) => js.context.callMethod('getBrowserName'),
      (false) => deviceInfo.deviceModel ?? "",
    };
  }
}
