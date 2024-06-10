import 'dart:math';
import 'package:dam_u2_ejercicio05_practica02/pokemon.dart';
import 'package:flutter/material.dart';

int randomIndex = Random().nextInt(pokemonNames.length);
String adivinaPokemonController = '';

List<Pokemon> pokemonNames = [
  Pokemon(name: 'clefable', type: 'hada'),
  Pokemon(name: 'clefairy', type: 'hada'),
  Pokemon(name: 'gloom', type: 'planta'),
  Pokemon(name: 'nidoking', type: 'tierra'),
  Pokemon(name: 'nidoqueen', type: 'tierra'),
  Pokemon(name: 'nidoran', type: 'veneno'),
  Pokemon(name: 'nidorina', type: 'veneno'),
  Pokemon(name: 'nidorino', type: 'veneno'),
  Pokemon(name: 'paras', type: 'bicho'),
  Pokemon(name: 'parasect', type: 'bicho'),
  Pokemon(name: 'pidgey', type: 'aire'),
  Pokemon(name: 'raichu', type: 'electrico'),
  Pokemon(name: 'vileplume', type: 'planta'),
];

enum PokemonType {
  agua,
  fuego,
  planta,
  bicho,
  normal,
  hada,
  aire,
  electrico,
  tierra,
}

PokemonType pokemonTypeGroupValue = PokemonType.agua;

class App05 extends StatefulWidget {
  const App05({super.key});

  @override
  State<App05> createState() => _App05State();
}

class _App05State extends State<App05> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: const Text('Tabs 2', style: TextStyle(color: Colors.white)),
            bottom: const TabBar(
              labelStyle: TextStyle(color: Colors.white),
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              tabs: [
                Tab(text: 'Tab1', icon: Icon(Icons.water_drop_outlined)),
                Tab(text: 'Tab2', icon: Icon(Icons.video_collection_outlined)),
                Tab(text: 'Pokemonos', icon: Icon(Icons.games_outlined)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              list1(),
              list2(),
              list3(),
            ],
          ),
        ));
  }

  // Adivina el tipo del pokemon, una imagen de un pokemon, con radio list tile
  Widget list1() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'ADIVINA EL TIPO',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Container(
            width: 150,
            height: 150,
            color: Colors.grey,
            child: Image.asset(
                'assets/pokemon/${pokemonNames[randomIndex].name}.png'),
          ),
          Expanded(
            child: ListView(
              children: drawRadioItems(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String mensaje = '';

              if (pokemonNames[randomIndex].type ==
                  pokemonTypeGroupValue.name) {
                mensaje = 'RESPUESTA CORRECTA';
              } else {
                mensaje = 'RESPUESTA INCORRECTA';
              }

              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('ATENCION'),
                      content: Text(mensaje),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              randomIndex =
                                  Random().nextInt(pokemonNames.length);
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('OTRO'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('REGRESAR'),
                        ),
                      ],
                    );
                  });
            },
            child: const Text('VERIFICAR'),
          ),
        ],
      ),
    );
  }

  List<Widget> drawRadioItems() {
    List<Widget> list = [];
    PokemonType.values.forEach((type) {
      list.add(
          RadioListTile(
          title: Text(type.name),
          value: type,
          groupValue: pokemonTypeGroupValue,
          onChanged: (item) {
            setState(() {
              pokemonTypeGroupValue = item as PokemonType;
            });
          },
        ),
      );
    });
    return list;
  }

  // Adivida el nombre del pokemon
  Widget list2() {
    // Retornar la imagen y el dropdown
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text('NOMBRE DEL POKEMON',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          Container(
            width: 150,
            height: 150,
            color: Colors.grey,
            child: Image.asset(
                'assets/pokemon/${pokemonNames[randomIndex].name}.png'),
          ),
          const Text(
            'Seleccionar y adivina el nombre del pokemon:',
            style: TextStyle(color: Colors.blue, fontSize: 15),
          ),
          DropdownButtonFormField(
              items: pokemonNames.map((e) {
                return DropdownMenuItem(
                  value: e.name,
                  child: Text(e.name),
                );
              }).toList(),
              onChanged: (item) {
                setState(() {
                  if (Pokemon.getIndex(pokemonNames, item.toString()) ==
                      randomIndex) {
                    adivinaPokemonController = 'Repuesta correcta';
                  } else {
                    adivinaPokemonController = 'Incorrecto, este no es $item';
                  }
                });
              }),
          Text(
            adivinaPokemonController,
            style: const TextStyle(color: Colors.red, fontSize: 20),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  adivinaPokemonController = '';
                  randomIndex = Random().nextInt(pokemonNames.length);
                });
              },
              child: const Text('Volver a jugar'))
        ],
      ),
    );
  }

  // Lista de pokemonos con GridView.builder
  Widget list3() {
    return GridView.builder(
        itemCount: pokemonNames.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('HAS ELEGIDO'),
                    content: Text(pokemonNames[index].name),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'))
                    ],
                  );
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              color: Colors.pinkAccent,
              width: 50,
              height: 50,
              child:
                  Image.asset('assets/pokemon/${pokemonNames[index].name}.png'),
            ),
          );
        });
  }
}
