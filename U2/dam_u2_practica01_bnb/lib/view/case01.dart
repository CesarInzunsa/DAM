import 'package:flutter/material.dart';
import '../model/music.dart';

class Case01 {
  Widget drawCase01(List<Music> musicList) {
    return GridView.builder(
      itemCount: musicList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Credits'),
                    content: Text(
                        'Song: ${musicList[index].title}\nPerformed by: ${musicList[index].artist}\nAlbum: ${musicList[index].album}'),
                  );
                });
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            width: 50,
            height: 50,
            child: Image.asset('assets/${musicList[index].title}.jpeg'),
          ),
        );
      },
    );
  }
}
