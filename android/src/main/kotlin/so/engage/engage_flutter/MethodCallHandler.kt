package so.engage.engage_flutter

import android.content.Context
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

internal class MethodCallHandler(
    context: Context,
    eventChannel: EventChannel,
    methodChannel: MethodChannel
): MethodChannel.MethodCallHandler {
    private var context: Context
    private var eventChannel: EventChannel
    private var methodChannel: MethodChannel

    init {
        this.context = context
        this.eventChannel = eventChannel
        this.methodChannel = methodChannel
    }

//    private lateinit var engage: Engage

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method) {
            "initialise" -> initialise(call, result)
            "identify" -> identify(call, result)
            "setDeviceToken" -> setDeviceToken(call, result)
            "logout" -> logout(call, result)
            "addToAccount" -> addToAccount(call, result)
            "addAttributes" -> addAttributes(call, result)
            "removeFromAccount" -> removeFromAccount(call, result)
            "changeAccountRole" -> changeAccountRole(call, result)
            "convertToCustomer" -> convertToCustomer(call, result)
            "convertToAccount" -> convertToAccount(call, result)
            "merge" -> merge(call, result)
            "track" -> track(call, result)
            else -> result.notImplemented()
        }
    }

    private fun initialise(call: MethodCall, result: MethodChannel.Result) {
        val publicKey: String? = call.argument("publicKey")
//        engage = Engage(context, publicKey)
    }

    private fun identify(call: MethodCall, result: MethodChannel.Result) {
        val uid: String = call.argument("uid") ?: return
        val properties: Map<String, Any> = call.argument("properties") ?: return
        // engage.idenify
    }

    private fun setDeviceToken(call: MethodCall, result: MethodChannel.Result) {
        val deviceToken: String = call.argument("deviceToken") ?: return
        val uid: String? = call.argument("uid")
        // engage.setDeviceToken
    }

    private fun logout(call: MethodCall, result: MethodChannel.Result) {
        val deviceToken: String = call.argument("deviceToken") ?: return
        val uid: String? = call.argument("uid")
        // engage.logout
    }

    private fun addToAccount(call: MethodCall, result: MethodChannel.Result) {
        val aid: String = call.argument("aid") ?: return
        val role: String? = call.argument("role")
        val uid: String? = call.argument("uid")
        // engage.addToAccount
    }

    private fun addAttributes(call: MethodCall, result: MethodChannel.Result) {
        val properties: Map<String, Any> = call.argument("properties") ?: return
        val uid: String? = call.argument("uid")
        // engage.addAttributes
    }

    private fun removeFromAccount(call: MethodCall, result: MethodChannel.Result) {
        val aid: String = call.argument("aid") ?: return
        val uid: String? = call.argument("uid")
        // engage.removeFromAccount
    }

    private fun changeAccountRole(call: MethodCall, result: MethodChannel.Result) {
        val aid: String = call.argument("aid") ?: return
        val role: String = call.argument("role") ?: return
        val uid: String? = call.argument("uid")
        // engage.changeAccountRole
    }

    private fun convertToCustomer(call: MethodCall, result: MethodChannel.Result) {
        val uid: String? = call.argument("uid")
        // engage.convertToCustomer
    }

    private fun convertToAccount(call: MethodCall, result: MethodChannel.Result) {
        val uid: String? = call.argument("uid")
        // engage.convertToAccount
    }

    private fun merge(call: MethodCall, result: MethodChannel.Result) {
        val source: String = call.argument("source") ?: return
        val destination: String = call.argument("destination") ?: return
        val uid: String? = call.argument("uid")
        // engage.changeAccountRole
    }

    private fun track(call: MethodCall, result: MethodChannel.Result) {
        val event: String = call.argument("event") ?: return
        val properties: Map<String, Any> = call.argument("properties") ?: return
        val uid: String? = call.argument("uid")
        // engage.track
    }
}