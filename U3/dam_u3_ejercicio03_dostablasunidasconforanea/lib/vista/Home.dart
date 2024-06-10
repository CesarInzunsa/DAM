import 'package:flutter/material.dart';
import '../controlador/artistaDB.dart';
import '../controlador/cancionDB.dart';
import '../modelo/artista.dart';
import '../modelo/cancion.dart';
import '../modelo/cancionArtista.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 1;
  List<Artista> listaArtista = [];

  List<CancionArtista> listaCancion = [];
  //List<Cancion> listaCancion = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    List<Artista> artistas = await ArtistaDB.getAll();
    setState(() {
      listaArtista = artistas;
    });
    List<CancionArtista> canciones = await CancionDB.getAllWithArtistName();
    setState(() {
      listaCancion = canciones;
    });
    // List<Cancion> canciones = await CancionDB.getAll();
    // setState(() {
    //   listaCancion = canciones;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.black,
        ),
        title: const Text('Home'),
      ),
      body: _drawBody(),
      bottomNavigationBar: NavigationBar(
        //labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _index,
        onDestinationSelected: (index) {
          setState(() {
            _index = index;
          });
        },
        indicatorColor: Colors.greenAccent,
        backgroundColor: Colors.white,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_add_alt),
            label: 'New artist',
          ),
          NavigationDestination(
            icon: Icon(Icons.music_note_outlined),
            label: 'New song',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'View artists',
          ),
          NavigationDestination(
            icon: Icon(Icons.queue_music_outlined),
            label: 'View songs',
          ),
        ],
      ),
    );
  }

  Widget _drawBody() {
    switch (_index) {
      case 0:
        return newArtist();
      case 1:
        return newSong();
      case 2:
        return viewArtists();
      default:
        return viewSongs();
    }
  }

  Widget viewArtists() {
    return ListView.builder(
      itemCount: listaArtista.length,
      itemBuilder: (context, index) {
        return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.greenAccent,
              child: Text(
                listaArtista[index].artistaID.toString(),
              ),
            ),
            title: Text(listaArtista[index].nombre),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Eliminar Artista'),
                      content: Text(
                        '¿Estás seguro de eliminar a ${listaArtista[index].nombre}?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            ArtistaDB.delete(listaArtista[index].artistaID)
                                .then((value) {
                              msj('Artista eliminado');
                            });
                            loadData();
                            Navigator.pop(context);
                          },
                          child: const Text('Eliminar'),
                        ),
                      ],
                    );
                  },
                );
              },
            ));
      },
    );
  }

  Widget viewSongs() {
    return ListView.builder(
      itemCount: listaCancion.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text(
              '1'
            ),
          ),
        );
      },
    );
  }

  final artistaID = TextEditingController();
  final nombreArtista = TextEditingController();

  Widget newArtist() {
    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        TextField(
          controller: artistaID,
          decoration: const InputDecoration(labelText: 'Artista ID'),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: nombreArtista,
          decoration: const InputDecoration(labelText: 'Nombre Artista'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              Artista artist = Artista(
                artistaID: int.parse(artistaID.text),
                nombre: nombreArtista.text,
              );
              ArtistaDB.insert(artist).then((value) {
                msj('Artista guardado');
              });
              loadData();
              clearArtistTextFields();
            },
            child: const Text('Guardar Artista')),
      ],
    );
  }

  void msj(String msj) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msj)),
    );
  }

  void clearArtistTextFields() {
    artistaID.clear();
    nombreArtista.clear();
  }

  final nombreCancion = TextEditingController();
  final album = TextEditingController();
  int artistSelected = 0;

  Widget newSong() {
    return ListView(
      padding: const EdgeInsets.all(22),
      children: [
        TextField(
          controller: nombreCancion,
          decoration: const InputDecoration(labelText: 'Nombre Cancion'),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: album,
          decoration: const InputDecoration(labelText: 'Album'),
        ),
        const SizedBox(height: 10),
        // DropdownButtonFormField(
        //   value: artistSelected,
        //   items: listaArtista.map((e) {
        //     return DropdownMenuItem(
        //       value: e.artistaID,
        //       child: Text(e.nombre),
        //     );
        //   }).toList(),
        //   onChanged: (value) {
        //     setState(() {
        //       artistSelected = value!;
        //     });
        //   },
        // ),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              Cancion cancion = Cancion(
                cancionID: 0,
                nombreCancion: nombreCancion.text,
                artistaID: artistSelected,
                album: album.text,
              );
              CancionDB.insert(cancion).then((value) {
                msj('Cancion guardada');
              });
              clearSongTextFields();
              loadData();
            },
            child: const Text('Guardar Cancion')),
      ],
    );
  }

  void clearSongTextFields() {
    nombreCancion.clear();
    album.clear();
    artistaID.clear();
  }
}
