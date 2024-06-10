import 'package:flutter/material.dart';
import '../model/music.dart';

class Case03 extends StatefulWidget {
  final List<Music> musicList;
  final TextEditingController nameController;

  const Case03({
    super.key,
    required this.musicList,
    required this.nameController,
  });

  @override
  State<Case03> createState() => _Case03State();
}

class _Case03State extends State<Case03> {
  List<Music> favorites = [];

  @override
  Widget build(BuildContext context) {
    favorites = _getFavorites();
    return Column(
      children: [
        _drawProfile(),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 13),
              child: Text('Recent favorites: ${favorites.length}'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(child: _drawCase03()),
      ],
    );
  }

  Widget _drawCase03() {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset('assets/${favorites[index].title}.jpeg'),
          title: Text(favorites[index].title),
          subtitle: Text(favorites[index].artist),
          trailing: IconButton(
            icon: favorites[index].stateFavorite
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_border),
            onPressed: () {
              setState(() {
                favorites[index].stateFavorite =
                    !favorites[index].stateFavorite;
              });
            },
          ),
        );
      },
    );
  }

  List<Music> _getFavorites() {
    List<Music> favorites = [];
    for (int i = 0; i < widget.musicList.length; i++) {
      if (widget.musicList[i].stateFavorite) {
        favorites.add(widget.musicList[i]);
      }
    }
    return favorites;
  }

  Widget _drawProfile() {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 55,
                child: Icon(Icons.person),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nameController.text.isEmpty
                        ? 'User name'
                        : widget.nameController.text,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const Text('0 followers - 11 following'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  showModal();
                },
                child: const Text('Edit'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showModal() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: widget.nameController,
                  decoration: InputDecoration(
                    hintText: widget.nameController.text.isEmpty
                        ? 'Enter your name'
                        : widget.nameController.text,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.nameController.text =
                                widget.nameController.text;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Update')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                  ],
                )
              ],
            ),
          );
        });
  }
}
