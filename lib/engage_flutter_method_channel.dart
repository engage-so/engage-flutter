import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'engage_flutter_platform_interface.dart';

/// An implementation of [EngagePlatform] that uses method channels.
class MethodChannelEngageFlutter extends EngageFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('engage');

  Function(Map<String, dynamic>)? _onMessaegOpenedHandler;
  Function(Map<String, dynamic>)? _onMessaegReceivedHandler;

  void setMethodCallHandler() {
    methodChannel.setMethodCallHandler((call) async {
      try {
        debugPrint('${call.method}: ${jsonEncode(call.arguments)}');

        final message = Map<String, dynamic>.from(call.arguments);
        if (call.method == 'onMessageOpened') {
          _onMessaegOpenedHandler?.call(message);
        }
        if (call.method == 'onMessageReceived') {
          _onMessaegReceivedHandler?.call(message);
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  @override
  Future<void> init({required String publicKey}) {
    setMethodCallHandler();
    return methodChannel.invokeMethod('initialise', {'publicKey': publicKey});
  }

  @override
  Future<void> addAttributes(Map<String, dynamic> properties, [String? uid]) {
    return methodChannel.invokeMethod(
      'addAttributes',
      {'properties': properties, 'uid': uid},
    );
  }

  @override
  Future<void> addToAccount(String aid, [String? role, String? uid]) {
    return methodChannel.invokeMethod(
      'addToAccount',
      {'aid': aid, 'role': role, 'uid': uid},
    );
  }

  @override
  Future<void> changeAccountRole(String aid, String role, [String? uid]) {
    return methodChannel.invokeMethod(
      'changeAccountRole',
      {'aid': aid, 'role': role, 'uid': uid},
    );
  }

  @override
  Future<void> convertToAccount([String? uid]) {
    return methodChannel.invokeMethod('convertToAccount', {'uid': uid});
  }

  @override
  Future<void> convertToCustomer([String? uid]) {
    return methodChannel.invokeMethod('convertToCustomer', {'uid': uid});
  }

  @override
  Future<void> identify(
    String uid, {
    Map<String, dynamic> properties = const {},
  }) {
    return methodChannel.invokeMethod(
      'identify',
      {'properties': properties, 'uid': uid},
    );
  }

  @override
  Future<void> logout(String deviceToken, [String? uid]) {
    return methodChannel.invokeMethod(
      'logout',
      {'deviceToken': deviceToken, 'uid': uid},
    );
  }

  @override
  Future<void> merge(String source, String destination) {
    return methodChannel.invokeMethod(
      'merge',
      {'source': source, 'destination': destination},
    );
  }

  @override
  Future<void> removeFromAccount(String aid, [String? uid]) {
    return methodChannel.invokeMethod(
      'removeFromAccount',
      {'aid': aid, 'uid': uid},
    );
  }

  @override
  Future<void> setDeviceToken(String deviceToken, [String? uid]) {
    return methodChannel.invokeMethod(
      'setDeviceToken',
      {'deviceToken': deviceToken, 'uid': uid},
    );
  }

  @override
  Future<void> track(
    String event, {
    Map<String, dynamic> value = const {},
    DateTime? date,
    String? uid,
  }) {
    return methodChannel.invokeMethod(
      'track',
      {'event': event, 'value': value, 'date': date, 'uid': uid},
    );
  }

  @override
  void onMessageOpened(Function(Map<String, dynamic>) callback) {
    _onMessaegOpenedHandler = callback;
  }

  @override
  void onMessageReceived(Function(Map<String, dynamic>) callback) {
    _onMessaegReceivedHandler = callback;
  }
}
