import 'package:flutter_test/flutter_test.dart';
import 'package:running_apps_macos/running_apps_macos_platform_interface.dart';
import 'package:running_apps_macos/running_apps_macos_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRunningAppsMacosPlatform
    with MockPlatformInterfaceMixin
    implements RunningAppsMacosPlatform {
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> getRunningApps() {
    throw UnimplementedError();
  }
}

void main() {
  final RunningAppsMacosPlatform initialPlatform =
      RunningAppsMacosPlatform.instance;

  test('$MethodChannelRunningAppsMacos is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRunningAppsMacos>());
  });
}
