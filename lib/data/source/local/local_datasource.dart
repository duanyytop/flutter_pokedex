import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../mappers/local_to_entity_mapper.dart';
import 'models/pokemon.dart';
import 'models/pokemon_gender.dart';
import 'models/pokemon_stats.dart';
import 'models/pokemon_type.dart';

@LazySingleton()
class LocalDataSource {
  static void initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(PokemonHiveModelAdapter(), PokemonHiveModel.boxTypeId);
    Hive.registerAdapter(
        PokemonGenderHiveModelAdapter(), PokemonGenderHiveModel.boxTypeId);
    Hive.registerAdapter(
        PokemonStatsHiveModelAdapter(), PokemonStatsHiveModel.boxTypeId);
    Hive.registerAdapter(
        PokemonsTypeHiveModelAdapter(), PokemonsTypeHiveModelX.boxTypeId);

    await Hive.openBox<PokemonHiveModel>(PokemonHiveModel.boxKey);
    await Hive.openBox<PokemonGenderHiveModel>(PokemonGenderHiveModel.boxKey);
    await Hive.openBox<PokemonStatsHiveModel>(PokemonStatsHiveModel.boxKey);
    await Hive.openBox<PokemonsTypeHiveModel>(PokemonsTypeHiveModelX.boxKey);
  }

  Future<bool> hasData() async {
    final pokemonBox = Hive.box<PokemonHiveModel>(PokemonHiveModel.boxKey);

    return pokemonBox.length > 0;
  }

  Future<void> savePokemons(Iterable<PokemonHiveModel> pokemons) async {
    final pokemonBox = Hive.box<PokemonHiveModel>(PokemonHiveModel.boxKey);

    await pokemonBox.clear();
    await pokemonBox.addAll(pokemons);
  }

  Future<List<PokemonHiveModel>> getPokemons({int page, int limit}) async {
    final pokemonBox = Hive.box<PokemonHiveModel>(PokemonHiveModel.boxKey);

    final start = (page - 1) * limit;

    final pokemons =
        List.generate(limit, (index) => pokemonBox.getAt(start + index));

    return pokemons;
  }
}
