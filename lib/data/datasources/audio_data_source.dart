import 'package:flutter/services.dart';
import '../../core/constants/app_constants.dart';
import '../../core/error/failures.dart';

class AudioDataSource {
  static const _channel = MethodChannel(AppConstants.channelAudio);

  Future<Map<String, dynamic>> getAudioState() async {
    try {
      final result =
          await _channel.invokeMethod<Map>('getAudioState');
      return Map<String, dynamic>.from(result ?? {});
    } on PlatformException catch (e) {
      throw PlatformFailure('getAudioState failed: ${e.message}');
    }
  }

  Future<bool> silence() async {
    try {
      final result =
          await _channel.invokeMethod<Map>('silence');
      return (result?['success'] as bool?) ?? false;
    } on PlatformException catch (e) {
      throw PlatformFailure('silence failed: ${e.message}');
    }
  }

  Future<bool> restore() async {
    try {
      final result =
          await _channel.invokeMethod<Map>('restore');
      return (result?['success'] as bool?) ?? false;
    } on PlatformException catch (e) {
      throw PlatformFailure('restore failed: ${e.message}');
    }
  }

  Future<bool> isSilenced() async {
    try {
      return await _channel.invokeMethod<bool>('isSilenced') ?? false;
    } on PlatformException catch (e) {
      throw PlatformFailure('isSilenced failed: ${e.message}');
    }
  }

  Future<int> getRingerMode() async {
    try {
      return await _channel.invokeMethod<int>('getRingerMode') ?? 2;
    } on PlatformException catch (e) {
      throw PlatformFailure('getRingerMode failed: ${e.message}');
    }
  }

  Future<bool> setRingerMode(int mode) async {
    try {
      final result =
          await _channel.invokeMethod<Map>('setRingerMode', {'mode': mode});
      return (result?['success'] as bool?) ?? false;
    } on PlatformException catch (e) {
      throw PlatformFailure('setRingerMode failed: ${e.message}');
    }
  }
}
