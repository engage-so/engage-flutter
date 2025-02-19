import Flutter
import UIKit
import Engage

public class MethodCallHandler: NSObject {
    var eventChannel: FlutterEventChannel
    var methodChannel: FlutterMethodChannel
    
    init(eventChannel: FlutterEventChannel, methodChannel: FlutterMethodChannel) {
        self.eventChannel = eventChannel
        self.methodChannel = methodChannel
        super.init()
    }
    
    let engage: Engage = Engage.shared
    
    public func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialise":
            initialise(call, result: result)
            return
        case "identify":
            identify(call, result: result)
            return
        case "setDeviceToken":
            setDeviceToken(call, result: result)
            return
        case "logout":
            logout(call, result: result)
            return
        case "addToAccount":
            addToAccount(call, result: result)
            return
        case "addAttributes":
            addAttributes(call, result: result)
            return
        case "removeFromAccount":
            removeFromAccount(call, result: result)
            return
        case "changeAccountRole":
            changeAccountRole(call, result: result)
            return
        case "convertToCustomer":
            convertToCustomer(call, result: result)
            return
        case "convertToAccount":
            convertToAccount(call, result: result)
            return
        case "merge":
            merge(call, result: result)
            return
        case "track":
            track(call, result: result)
            return
        default:
            result(FlutterMethodNotImplemented)
            return
        }
    }
    
    
    private func initialise(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any>,
           let publicKey = args["publicKey"] as? String {
            let _ = engage.initialise(publicKey: publicKey)
        }
    }
    
    private func identify(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any>,
           let uid = args["uid"] as? String,
           let properties = args["properties"] as? Dictionary<String, Any> {
            engage.identify(uid: uid, properties: properties)
        }
    }
    
    private func setDeviceToken(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any>,
           let deviceToken = args["deviceToken"] as? String {
            let uid = args["uid"] as? String
            engage.setDeviceToken(deviceToken: deviceToken, uid: uid)
        }
    }
    
    private func logout(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any>,
           let deviceToken = args["deviceToken"] as? String {
            let uid = args["uid"] as? String
            engage.logout(deviceToken: deviceToken, uid: uid)
        }
    }
    
    private func addToAccount(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any>,
           let aid = args["aid"] as? String {
            let role = args["role"] as? String
            let uid = args["uid"] as? String
            engage.addToAccount(aid: aid, role: role, uid: uid)
        }
    }
    
    private func addAttributes(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any>,
           let properties = args["properties"] as? Dictionary<String, Any> {
            let uid = args["uid"] as? String
            engage.addAttributes(properties: properties, uid: uid)
        }
    }
    
    private func removeFromAccount(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any>,
           let aid = args["aid"] as? String {
            let uid = args["uid"] as? String
            engage.removeFromAccount(aid: aid, uid: uid)
        }
    }
    
    private func changeAccountRole(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any>,
           let aid = args["aid"] as? String,
           let role = args["role"] as? String {
            let uid = args["uid"] as? String
            engage.changeAccountRole(aid: aid, role: role, uid: uid)
        }
    }
    
    private func convertToCustomer(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any> {
            let uid = args["uid"] as? String
            engage.convertToCustomer(uid: uid)
        }
    }
    
    private func convertToAccount(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any> {
            let uid = args["uid"] as? String
            engage.convertToAccount(uid: uid)
        }
    }
    
    private func merge(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any>,
           let source = args["source"] as? String,
           let destination = args["destination"] as? String {
            engage.merge(source: source, destination: destination)
        }
    }
    
    private func track(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any>,
           let event = args["event"] as? String {
            let value = args["value"] as? Dictionary<String, Any>
            let date = args["date"] as? Date
            let uid = args["uid"] as? String
            engage.track(event: event, value: value, date: date, uid: uid)
        }
    }
}
