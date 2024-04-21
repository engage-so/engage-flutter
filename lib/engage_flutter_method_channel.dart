import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'engage_flutter_platform_interface.dart';

/// An implementation of [EngagePlatform] that uses method channels.
class MethodChannelEngageFlutter extends EngageFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('engage');

  @visibleForTesting
  final eventChannel = const EventChannel('engage/event');

  @override
  Future<void> listen() async {
    debugPrint('Listening to: ${eventChannel.name}');
    await for (final event in eventChannel.receiveBroadcastStream()) {
      try {
        debugPrint('${eventChannel.name}: ${jsonEncode(event)}');
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  @override
  Future<void> initialise({required String publicKey}) {
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
    Map<String, dynamic> properties = const {},
    String? uid,
  }) {
    return methodChannel.invokeMethod(
      'track',
      {'event': event, 'properties': properties, 'uid': uid},
    );
  }
}
