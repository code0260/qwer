import 'package:almonazim/core/helper/functions/custom%20dialogs/my_snack_bar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:toastification/toastification.dart';

class SoundPlayer {
  // JustAudio recommends creating a new player for each sound for short assets
  static AudioPlayer? _audioPlayer;

  /// Plays a sound from the given asset path.
  static Future<void> playSound(String asset) async {
    try {
      // Dispose previous player if it exists
      await _audioPlayer?.dispose();

      // Create a new player instance
      _audioPlayer = AudioPlayer();

      // Load and play asset
      await _audioPlayer!.setAsset('assets/$asset');
      await _audioPlayer!.setVolume(0.7); // 70% of current system volume
      await _audioPlayer!.play();
    } catch (e) {
      mySnackBar(ToastificationType.error, 'خطأ', e.toString());
    }
  }

  /// Optionally dispose when needed
  static Future<void> dispose() async {
    await _audioPlayer?.dispose();
    _audioPlayer = null;
  }
}
