import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:running_apps_macos/running_apps_macos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _runningAppsMacosPlugin = RunningAppsMacos();
  AppsRunning _appsRunning = AppsRunning(apps: []);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initRunningAppsState();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      print("Updating running apps...");
      initRunningAppsState();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> initRunningAppsState() async {
    String? runningApps;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      runningApps = await _runningAppsMacosPlugin.getRunningApps();
    } on PlatformException {
      runningApps = "";
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (runningApps != null && runningApps.isNotEmpty) {
      final json = jsonDecode(runningApps);
      setState(() {
        _appsRunning = AppsRunning.fromJson(json);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Getting running apps on macOS'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              if (_appsRunning.apps.isNotEmpty)
                Text("N. of Apps: ${_appsRunning.apps.length}"),
              const Text("Apps running on device:\n\n"),
              if (_appsRunning.apps.isNotEmpty)
                for (var app in _appsRunning.apps)
                  Text("PID: ${app.pid}: ${app.name} - ${app.bundleId}"),
            ]),
          ),
        ),
      ),
    );
  }
}
