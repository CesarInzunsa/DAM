import 'package:flutter/material.dart';
import '../model/music.dart';

class Case02 extends StatefulWidget {
  final List<Music> musicList;

  const Case02({super.key, required this.musicList});

  @override
  State<Case02> createState() => _Case02State();
}

class _Case02State extends State<Case02> {
  List<Music> musicListWithFilter = [];

  @override
  Widget build(BuildContext context) {
    return drawCase02();
  }

  Widget drawCase02() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          child: TextField(
            onChanged: (query) {
              setState(() {
                _filterSearchResults(query);
              });
            },
            decoration: const InputDecoration(
              hintText: 'Find your favorite music here!',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(height: 22),
        Expanded(
          child: ListView(children: _drawMusicListTile()),
        ),
      ],
    );
  }

  void _filterSearchResults(String query) {
    if (query.isEmpty) musicListWithFilter = widget.musicList;
    musicListWithFilter = widget.musicList
        .where(
            (music) => music.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<ListTile> _drawMusicListTile() {
    List<ListTile> listTile = [];

    for (int i = 0; i < musicListWithFilter.length; i++) {
      listTile.add(
        ListTile(
          leading: Image.asset('assets/${musicListWithFilter[i].title}.jpeg'),
          title: Text(musicListWithFilter[i].title),
          subtitle: Text(musicListWithFilter[i].artist),
          trailing: IconButton(
            icon: musicListWithFilter[i].stateFavorite
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_border),
            onPressed: () {
              _changeStateFavoriteAt(i);
            },
          ),
        ),
      );
    }
    return listTile;
  }

  void _changeStateFavoriteAt(int index) {
    var title = musicListWithFilter[index].title;
    setState(() {
      widget.musicList
          .firstWhere((music) => music.title == title)
          .stateFavorite = !musicListWithFilter[index].stateFavorite;
    });
  }
}
