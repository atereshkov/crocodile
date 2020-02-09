import 'package:crocodile_game/app/model/enum/enums.dart';
import 'package:crocodile_game/app/service/audio_player/audio_player_type.dart';
import 'package:audioplayers/audio_cache.dart';

class AudioPlayer implements AudioPlayerType {

  AudioCache player = AudioCache(prefix: 'audio/');

  AudioPlayer();

  @override
  void play(SoundType sound) {
    switch (sound) {
      case SoundType.timeIsUp:
        player.play('time_is_up.mp3');
        break;
      case SoundType.correct:
        player.play('correct.mp3');
        break;
      case SoundType.incorrect:
        player.play('incorrect.mp3');
        break;
    }
  }

}
