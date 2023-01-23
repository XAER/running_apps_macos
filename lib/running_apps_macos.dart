import 'running_apps_macos_platform_interface.dart';
import 'dart:ffi';

final DynamicLibrary nativeAddLib = DynamicLibrary.process();

final int Function(int x, int y) nativeAdd = nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('native_add')
    .asFunction();

class RunningAppsMacos {
  Future<String?> getRunningApps() {
    return RunningAppsMacosPlatform.instance.getRunningApps();
  }
}

class AppsRunning {
  final List<Apps> apps;

  AppsRunning({required this.apps});

  factory AppsRunning.fromJson(Map<String, dynamic> json) {
    return AppsRunning(
        apps: (json['apps'] as List).map((e) => Apps.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    return {'apps': apps.map((e) => e.toJson()).toList()};
  }
}

class Apps {
  final String name;
  final int pid;
  final String bundleId;

  Apps({required this.name, required this.pid, required this.bundleId});

  factory Apps.fromJson(Map<String, dynamic> json) {
    return Apps(
        name: json['name'], pid: json['pid'], bundleId: json['bundleId']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'pid': pid, 'bundleId': bundleId};
  }
}
