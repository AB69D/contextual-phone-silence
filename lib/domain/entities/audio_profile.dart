import 'package:equatable/equatable.dart';

enum AudioProfileMode { normal, silent, vibrate }

class AudioProfile extends Equatable {
  const AudioProfile(this.mode);
  final AudioProfileMode mode;

  int get androidRingerMode => switch (mode) {
    AudioProfileMode.normal => 2,
    AudioProfileMode.vibrate => 1,
    AudioProfileMode.silent => 0,
  };

  static AudioProfile fromAndroidRingerMode(int mode) => switch (mode) {
    0 => const AudioProfile(AudioProfileMode.silent),
    1 => const AudioProfile(AudioProfileMode.vibrate),
    _ => const AudioProfile(AudioProfileMode.normal),
  };

  static const normal = AudioProfile(AudioProfileMode.normal);
  static const silent = AudioProfile(AudioProfileMode.silent);
  static const vibrate = AudioProfile(AudioProfileMode.vibrate);

  bool get isSilent => mode == AudioProfileMode.silent;
  bool get isNormal => mode == AudioProfileMode.normal;

  @override
  List<Object?> get props => [mode];
}
