import Flutter
import UIKit
import Engage

public class EngageFlutterPlugin: NSObject, FlutterPlugin {
    public static let channelId = "engage"
    public static let eventChannelId = "engage/event";
    public static var handler: MethodCallHandler?;
    public static var eventSink: FlutterEventSink?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: channelId, binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: eventChannelId, binaryMessenger: registrar.messenger())
        let instance = EngageFlutterPlugin()
        eventChannel.setStreamHandler(instance)
        
        NotificationHandler.shared.setOnMessageOpened { message in
            eventSink?(["type": "setOnMessageOpened", "data": message])
        }
        
        NotificationHandler.shared.setOnMessageReceived { message in
            eventSink?(["type": "setOnMessageReceived", "data": message])
        }
        handler = MethodCallHandler(eventChannel: eventChannel, methodChannel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        EngageFlutterPlugin.handler?.handle(call: call, result: result)
    }
}

extension EngageFlutterPlugin: FlutterStreamHandler {
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        EngageFlutterPlugin.eventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        EngageFlutterPlugin.eventSink = nil
        return nil
    }
}
