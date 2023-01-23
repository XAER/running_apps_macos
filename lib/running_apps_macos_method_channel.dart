import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'running_apps_macos_platform_interface.dart';

/// An implementation of [RunningAppsMacosPlatform] that uses method channels.
class MethodChannelRunningAppsMacos extends RunningAppsMacosPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('running_apps_macos');

  @override
  Future<String?> getRunningApps() async {
    final runningApps =
        await methodChannel.invokeMethod<String>('getRunningApps');
    return '{"apps": [${runningApps!.replaceAll("[", "{").replaceAll("]", "}")}] }';
  }
}
