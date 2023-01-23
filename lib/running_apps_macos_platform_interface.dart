import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'running_apps_macos_method_channel.dart';

abstract class RunningAppsMacosPlatform extends PlatformInterface {
  /// Constructs a RunningAppsMacosPlatform.
  RunningAppsMacosPlatform() : super(token: _token);

  static final Object _token = Object();

  static RunningAppsMacosPlatform _instance = MethodChannelRunningAppsMacos();

  /// The default instance of [RunningAppsMacosPlatform] to use.
  ///
  /// Defaults to [MethodChannelRunningAppsMacos].
  static RunningAppsMacosPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RunningAppsMacosPlatform] when
  /// they register themselves.
  static set instance(RunningAppsMacosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getRunningApps() {
    throw UnimplementedError('getRunningApps() has not been implemented.');
  }
}
