import '../../../core/extensions.dart';
import '../github/models/pokemon.dart';
import '../local/models/pokemon.dart';
import '../local/models/pokemon_gender.dart';
import '../local/models/pokemon_stats.dart';
import 'local_to_entity_mapper.dart';

extension GithubPokemonModelToLocalX on GithubPokemonModel {
  PokemonHiveModel toHiveModel() => PokemonHiveModel()
    ..number = id?.trim() ?? ''
    ..name = name?.trim() ?? ''
    ..description = xDescription?.trim() ?? ''
    ..types = types
        .map((e) => PokemonsTypeHiveModelX.parse(e?.trim()))
        .toList(growable: false)
    ..image = imageUrl?.trim() ?? ''
    ..height = height?.trim() ?? ''
    ..weight = weight?.trim() ?? ''
    ..genera = category?.trim() ?? ''
    ..eggGroups = eggGroups
        .split(r',\s*?')
        .map((e) => PokemonsTypeHiveModelX.parse(e?.trim()))
        .toList(growable: false)
    ..gender = (PokemonGenderHiveModel()
      ..male = genderMalePercentage?.parseDouble() ?? 0.0
      ..female = genderFemalePercentage?.parseDouble() ?? 0.0
      ..genderless = genderless == 1)
    ..stats = (PokemonStatsHiveModel()
      ..hp = hp?.toInt() ?? 0
      ..speed = speed?.toInt() ?? 0
      ..attack = attack?.toInt() ?? 0
      ..defense = defense?.toInt() ?? 0
      ..specialAttack = specialAttack?.toInt() ?? 0
      ..specialDefense = specialDefense?.toInt() ?? 0);
}
