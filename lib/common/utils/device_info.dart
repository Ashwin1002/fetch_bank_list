import 'package:flutter/foundation.dart';
import 'package:universal_html/js.dart'as js;
import '../../messages.g.dart';

class DeviceInfoService {

  static Future<String> getDeviceModel() async {
    String deviceModel = "";
    if (!kIsWeb) {
      final deviceInfoApi = DeviceInfoApi();
      final deviceInfo = await deviceInfoApi.getDeviceInfo();
      deviceModel = deviceInfo.deviceModel ?? "";
    } else {
      deviceModel = js.context.callMethod('getBrowserName');
    }
    return deviceModel;
  }
}