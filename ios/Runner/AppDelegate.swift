import UIKit
import Flutter


class DeviceInfoApiImpl: NSObject, DeviceInfoApi {
    func getDeviceInfo() -> DeviceInfo {
        var deviceInfo = DeviceInfo()
        deviceInfo.deviceModel = UIDevice.current.model
        deviceInfo.deviceName = UIDevice.current.name // You can customize this for iOS
        return deviceInfo
    }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller = window?.rootViewController as! FlutterViewController
    let api = DeviceInfoApiImpl()
          DeviceInfoApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: api)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
