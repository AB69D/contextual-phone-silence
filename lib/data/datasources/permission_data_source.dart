import 'package:flutter/services.dart';
import '../../core/constants/app_constants.dart';
import '../../core/error/failures.dart';

class PermissionDataSource {
  static const _channel =
      MethodChannel(AppConstants.channelPermissions);

  Future<Map<String, dynamic>> checkAll() async {
    try {
      final result = await _channel.invokeMethod<Map>('checkAll');
      return Map<String, dynamic>.from(result ?? {});
    } on PlatformException catch (e) {
      throw PlatformFailure('checkAll failed: ${e.message}');
    }
  }

  Future<void> openDndSettings() async {
    try {
      await _channel.invokeMethod('openDndSettings');
    } on PlatformException catch (e) {
      throw PlatformFailure('openDndSettings failed: ${e.message}');
    }
  }

  Future<void> openExactAlarmSettings() async {
    try {
      await _channel.invokeMethod('openExactAlarmSettings');
    } on PlatformException catch (e) {
      throw PlatformFailure('openExactAlarmSettings failed: ${e.message}');
    }
  }

  Future<void> openBatteryOptimizationSettings() async {
    try {
      await _channel.invokeMethod('openBatteryOptimizationSettings');
    } on PlatformException catch (e) {
      throw PlatformFailure(
          'openBatteryOptimizationSettings failed: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> getOemBatterySteps() async {
    try {
      final result =
          await _channel.invokeMethod<List>('getOemBatterySteps');
      return (result ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    } on PlatformException catch (e) {
      throw PlatformFailure('getOemBatterySteps failed: ${e.message}');
    }
  }

  Future<void> launchOemBatteryStep(int stepIndex) async {
    try {
      await _channel
          .invokeMethod('launchOemBatteryStep', {'stepIndex': stepIndex});
    } on PlatformException catch (e) {
      throw PlatformFailure('launchOemBatteryStep failed: ${e.message}');
    }
  }

  Future<void> openAppSettings() async {
    try {
      await _channel.invokeMethod('openAppSettings');
    } on PlatformException catch (e) {
      throw PlatformFailure('openAppSettings failed: ${e.message}');
    }
  }
}
