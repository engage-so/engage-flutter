import 'package:flutter_test/flutter_test.dart';
import 'package:engage_flutter/engage_flutter_platform_interface.dart';
import 'package:engage_flutter/engage_flutter_method_channel.dart';

// class MockEngageFlutterPlatform
//     with MockPlatformInterfaceMixin
//     implements EngageFlutterPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

void main() {
  final EngageFlutterPlatform initialPlatform = EngageFlutterPlatform.instance;

  test('$MethodChannelEngageFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEngageFlutter>());
  });

  test('getPlatformVersion', () async {
    // EngageFlutter engageFlutterPlugin = EngageFlutter();
    // MockEngageFlutterPlatform fakePlatform = MockEngageFlutterPlatform();
    // EngageFlutterPlatform.instance = fakePlatform;

    // expect(await engageFlutterPlugin.getPlatformVersion(), '42');
  });
}
