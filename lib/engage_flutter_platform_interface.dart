import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'engage_flutter_method_channel.dart';

abstract class EngageFlutterPlatform extends PlatformInterface {
  /// Constructs a EngagePlatform.
  EngageFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static EngageFlutterPlatform _instance = MethodChannelEngageFlutter();

  /// The default instance of [EngagePlatform] to use.
  ///
  /// Defaults to [MethodChannelEngageFlutter].
  static EngageFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EngagePlatform] when
  /// they register themselves.
  static set instance(EngageFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> listen() {
    throw UnimplementedError('listen() has not been implemented.');
  }

  Future<void> initialise({required String publicKey}) {
    throw UnimplementedError('initialise() has not been implemented.');
  }

  Future<void> identify(
    String uid, {
    Map<String, dynamic> properties = const {},
  }) {
    throw UnimplementedError('identify() has not been implemented.');
  }

  Future<void> setDeviceToken(String deviceToken, [String? uid]) {
    throw UnimplementedError('setDeviceToken() has not been implemented.');
  }

  Future<void> logout(String deviceToken, [String? uid]) {
    throw UnimplementedError('logout() has not been implemented.');
  }

  Future<void> addToAccount(String aid, [String? role, String? uid]) {
    throw UnimplementedError('addToAccount() has not been implemented.');
  }

  Future<void> addAttributes(Map<String, dynamic> properties, [String? uid]) {
    throw UnimplementedError('addAttributes() has not been implemented.');
  }

  Future<void> removeFromAccount(String aid, [String? uid]) {
    throw UnimplementedError('removeFromAccount() has not been implemented.');
  }

  Future<void> changeAccountRole(String aid, String role, [String? uid]) {
    throw UnimplementedError('changeAccountRole() has not been implemented.');
  }

  Future<void> convertToCustomer([String? uid]) {
    throw UnimplementedError('convertToCustomer() has not been implemented.');
  }

  Future<void> convertToAccount([String? uid]) {
    throw UnimplementedError('convertToAccount() has not been implemented.');
  }

  Future<void> merge(String source, String destination) {
    throw UnimplementedError('merge() has not been implemented.');
  }

  Future<void> track(
    String event, {
    Map<String, dynamic> value = const {},
    DateTime? date,
    String? uid,
  }) {
    throw UnimplementedError('track() has not been implemented.');
  }

  Future<void> showDialog({required bool isCarousel}) {
    throw UnimplementedError('showDialog() has not been implemented.');
  }
}
