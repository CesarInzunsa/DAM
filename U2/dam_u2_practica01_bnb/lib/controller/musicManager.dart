import '../model/music.dart';

class MusicManager {
  final List<Music> _musicList = [
    Music(
      title: 'After Dark',
      artist: 'Mr.Kitty',
      album: 'Time',
      stateFavorite: false,
    ),
    Music(
      title: 'Another Day Of Sun',
      artist: 'La La Land Cast',
      album: 'La La Land (Original Motion Picture Soundtrack)',
      stateFavorite: false,
    ),
    Music(
      title: 'Bellbottoms',
      artist: 'The Jon Spencer Blues Explosion',
      album: 'Orange',
      stateFavorite: false,
    ),
    Music(
      title: 'Future',
      artist: 'Red Velvet',
      album: 'START-UP (Original Television Soundtrack), Pt. 1',
      stateFavorite: false,
    ),
    Music(
      title: 'Molinos De Viento',
      artist: 'Mägo de Oz',
      album: 'La Leyenda De La Mancha',
      stateFavorite: false,
    ),
    Music(
      title: 'This fffire',
      artist: 'Franz Ferdinand',
      album: 'This fffire',
      stateFavorite: false,
    ),
  ];

  List<Music> get musicList => _musicList;

  bool changeStateFavoriteAt(int index) {
    if (index < 0 || index >= _musicList.length) return false;
    _musicList[index].stateFavorite = !_musicList[index].stateFavorite;
    return true;
  }
}
