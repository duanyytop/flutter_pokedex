import '../../../core/extensions.dart';
import '../../../domain/entities/pokemon.dart';
import '../../../domain/entities/pokemon_props.dart';
import '../../../domain/entities/pokemon_types.dart';
import '../github/models/pokemon.dart';

extension GithubPokemonModelToEntityX on GithubPokemonModel {
  Pokemon toEntity() => Pokemon(
        number: id?.trim() ?? '',
        name: name?.trim() ?? '',
        description: xDescription?.trim() ?? '',
        types: types.map((e) => PokemonTypesX.parse(e?.trim())).toList(),
        image: imageUrl?.trim() ?? '',
        height: height?.trim() ?? '',
        weight: weight?.trim() ?? '',
        genera: category?.trim() ?? '',
        eggGroups: eggGroups
            .split(r',\s*?')
            .map((e) => PokemonTypesX.parse(e?.trim()))
            .toList(),
        gender: PokemonGender(
          male: genderMalePercentage.parseDouble(),
          female: genderFemalePercentage.parseDouble(),
          genderless: genderless == 1,
        ),
        stats: PokemonStats(
          hp: hp?.toInt() ?? 0,
          speed: speed?.toInt() ?? 0,
          attack: attack?.toInt() ?? 0,
          defense: defense?.toInt() ?? 0,
          specialAttack: specialAttack?.toInt() ?? 0,
          specialDefense: specialDefense?.toInt() ?? 0,
        ),
      );
}
