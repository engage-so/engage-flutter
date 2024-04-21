import 'package:engage_flutter/engage_flutter_platform_interface.dart';

class Engage {
  Engage._();

  static final Engage _instance = Engage._();

  /// get the instance of the [Engage].
  static Engage get instance => _instance;

  Future<void> initialise({required String publicKey}) {
    return EngageFlutterPlatform.instance.initialise(publicKey: publicKey);
  }

  Future<void> identify(
    String uid, {
    Map<String, dynamic> properties = const {},
  }) {
    return EngageFlutterPlatform.instance.identify(uid, properties: properties);
  }

  Future<void> setDeviceToken(String deviceToken, [String? uid]) {
    return EngageFlutterPlatform.instance.setDeviceToken(deviceToken, uid);
  }

  Future<void> logout(String deviceToken, [String? uid]) {
    return EngageFlutterPlatform.instance.logout(deviceToken, uid);
  }

  Future<void> addToAccount(String aid, [String? role, String? uid]) {
    return EngageFlutterPlatform.instance.addToAccount(aid, role, uid);
  }

  Future<void> addAttributes(Map<String, dynamic> properties, [String? uid]) {
    return EngageFlutterPlatform.instance.addAttributes(properties, uid);
  }

  Future<void> removeFromAccount(String aid, [String? uid]) {
    return EngageFlutterPlatform.instance.removeFromAccount(aid, uid);
  }

  Future<void> changeAccountRole(String aid, String role, [String? uid]) {
    return EngageFlutterPlatform.instance.changeAccountRole(aid, role, uid);
  }

  Future<void> convertToCustomer([String? uid]) {
    return EngageFlutterPlatform.instance.convertToCustomer(uid);
  }

  Future<void> convertToAccount([String? uid]) {
    return EngageFlutterPlatform.instance.convertToAccount(uid);
  }

  Future<void> merge(String source, String destination) {
    return EngageFlutterPlatform.instance.merge(source, destination);
  }

  Future<void> track(
    String event, {
    Map<String, dynamic> properties = const {},
    String? uid,
  }) {
    return EngageFlutterPlatform.instance
        .track(event, properties: properties, uid: uid);
  }
}
