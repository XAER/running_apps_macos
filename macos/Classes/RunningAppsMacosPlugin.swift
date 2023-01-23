import Cocoa
import FlutterMacOS

public class RunningAppsMacosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "running_apps_macos", binaryMessenger: registrar.messenger)
    let instance = RunningAppsMacosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    case "getRunningApps":
      let runningApps = NSWorkspace.shared.runningApplications
      var apps = [[String: Any]]()
      for app in runningApps {
          apps.append([
              "name": app.localizedName ?? "",
              "bundleId": app.bundleIdentifier ?? "",
              "pid": app.processIdentifier
          ])
        }
      // Return apps as a string
      result(apps.map { $0.description }.joined(separator: ", "))
        
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
