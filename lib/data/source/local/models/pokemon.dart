import 'package:hive/hive.dart';

import 'pokemon_gender.dart';
import 'pokemon_stats.dart';
import 'pokemon_type.dart';

part 'pokemon.g.dart';

@HiveType()
class PokemonHiveModel extends HiveObject {
  static const int boxTypeId = 0;
  static const String boxKey = 'pokemon';

  @HiveField(0)
  String number;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  List<PokemonsTypeHiveModel> types;

  @HiveField(4)
  String image;

  @HiveField(5)
  String height;

  @HiveField(6)
  String weight;

  @HiveField(7)
  String genera;

  @HiveField(8)
  List<PokemonsTypeHiveModel> eggGroups;

  @HiveField(9)
  PokemonGenderHiveModel gender;

  @HiveField(10)
  PokemonStatsHiveModel stats;
}
