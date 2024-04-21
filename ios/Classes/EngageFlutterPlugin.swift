import Flutter
import UIKit

public class EngageFlutterPlugin: NSObject, FlutterPlugin {
  public static let channelId = "engage"
  public static let eventChannelId = "engage/event";
  public static var handler: MethodCallHandler?;

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: channelId, binaryMessenger: registrar.messenger())
    let eventChannel = FlutterEventChannel(name: eventChannelId, binaryMessenger: registrar.messenger())
    let instance = EngageFlutterPlugin()
    handler = MethodCallHandler(eventChannel: eventChannel, methodChannel: channel)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    EngageFlutterPlugin.handler?.handle(call: call, result: result)
  }
}
