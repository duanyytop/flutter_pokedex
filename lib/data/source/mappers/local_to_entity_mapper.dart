import '../../../core/extensions.dart';
import '../../../core/utils.dart';
import '../../../domain/entities/pokemon.dart';
import '../../../domain/entities/pokemon_props.dart';
import '../../../domain/entities/pokemon_types.dart';
import '../local/models/pokemon.dart';
import '../local/models/pokemon_gender.dart';
import '../local/models/pokemon_stats.dart';
import '../local/models/pokemon_type.dart';

extension PokemonHiveModelX on PokemonHiveModel {
  Pokemon toEntity() => Pokemon(
        number: number?.trim() ?? '',
        name: name?.trim() ?? '',
        description: description?.trim() ?? '',
        types: types.map((e) => e.toEntity()).toList(),
        image: image?.trim() ?? '',
        height: height?.trim() ?? '',
        weight: weight?.trim() ?? '',
        genera: genera?.trim() ?? '',
        eggGroups: eggGroups.map((e) => e.toEntity()).toList(),
        gender: gender.toEntity(),
        stats: stats.toEntity(),
      );
}

extension PokemonGenderHiveModelX on PokemonGenderHiveModel {
  PokemonGender toEntity() => PokemonGender(
        male: male ?? 0.0,
        female: female ?? 0.0,
        genderless: genderless ?? false,
      );
}

extension PokemonStatsHiveModelX on PokemonStatsHiveModel {
  PokemonStats toEntity() => PokemonStats(
        attack: attack ?? 0,
        specialAttack: specialAttack ?? 0,
        defense: defense ?? 0,
        specialDefense: specialDefense ?? 0,
        hp: hp ?? 0,
        speed: speed ?? 0,
      );
}

extension PokemonsTypeHiveModelX on PokemonsTypeHiveModel {
  static const int boxTypeId = 3;
  static const String boxKey = 'pokemonTypes';

  PokemonTypes toEntity() => PokemonTypesX.parse(value);

  String get value => getEnumValue(this).capitalize();

  static PokemonsTypeHiveModel parse(String rawValue) {
    final type = PokemonsTypeHiveModel.values.firstWhere(
      (element) => element.value.toLowerCase() == rawValue.toLowerCase(),
      orElse: () => PokemonsTypeHiveModel.unknown,
    );

    return type;
  }
}
