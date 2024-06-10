class Pokemon {
  String name;
  String type;

  Pokemon({required this.name, required this.type});

  static int getIndex(List<Pokemon> pokemonNames, String name) {
    for (var i = 0; i < pokemonNames.length; i++) {
      if (pokemonNames[i].name == name) {
        return i;
      }
    }
    return -1;
  }
}
