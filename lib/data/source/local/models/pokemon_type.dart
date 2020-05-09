import 'package:hive/hive.dart';

part 'pokemon_type.g.dart';

@HiveType()
enum PokemonsTypeHiveModel {
  @HiveField(0)
  grass,

  @HiveField(1)
  poison,

  @HiveField(2)
  fire,

  @HiveField(3)
  flying,

  @HiveField(4)
  water,

  @HiveField(5)
  bug,

  @HiveField(6)
  normal,

  @HiveField(7)
  electric,

  @HiveField(8)
  ground,

  @HiveField(9)
  fairy,

  @HiveField(10)
  fighting,

  @HiveField(11)
  psychic,

  @HiveField(12)
  rock,

  @HiveField(13)
  steel,

  @HiveField(14)
  ice,

  @HiveField(15)
  ghost,

  @HiveField(16)
  dragon,

  @HiveField(17)
  dark,

  @HiveField(18)
  unknown,
}
