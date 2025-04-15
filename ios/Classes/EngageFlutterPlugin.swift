import Flutter
import UIKit
import Engage

public class EngageFlutterPlugin: NSObject, FlutterPlugin {
    public static let channelId = "engage"
    public static var handler: MethodCallHandler?;
    private var channel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: channelId, binaryMessenger: registrar.messenger())
        let instance = EngageFlutterPlugin()
        instance.channel = channel
        
        NotificationHandler.shared.setOnMessageOpened { message in
            channel.invokeMethod("onMessageOpened", arguments: message)
        }
        
        NotificationHandler.shared.setOnMessageReceived { message in
            channel.invokeMethod("onMessageReceived", arguments: message)
        }
        handler = MethodCallHandler(methodChannel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
    }
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        EngageFlutterPlugin.handler?.handle(call: call, result: result)
    }
    
    @objc func application(didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) -> Bool {
        NotificationHandler.shared.setAPNsToken(deviceToken)
        
        return true
    }
}
