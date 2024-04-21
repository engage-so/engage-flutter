package so.engage.engage_flutter

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

/** EngagePlugin */
class EngageFlutterPlugin: FlutterPlugin {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private val channelId = "engage"
  private val eventChannelId = "engage/event"
  private lateinit var eventChannel: EventChannel
  private var handler: MethodCallHandler? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, channelId)
    eventChannel = EventChannel(binding.binaryMessenger, eventChannelId)
    handler = MethodCallHandler(binding.applicationContext, eventChannel, channel)
    channel.setMethodCallHandler(handler)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    handler = null
    channel.setMethodCallHandler(null)
  }
}
