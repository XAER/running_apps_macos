import 'package:flutter_test/flutter_test.dart';
import 'package:running_apps_macos/running_apps_macos_method_channel.dart';

void main() {
  MethodChannelRunningAppsMacos platform = MethodChannelRunningAppsMacos();

  TestWidgetsFlutterBinding.ensureInitialized();

  expect(platform.getRunningApps(), '{"apps": [] }');
}
