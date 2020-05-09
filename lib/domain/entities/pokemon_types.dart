import '../../core/extensions.dart';
import '../../core/utils.dart';

enum PokemonTypes {
  grass,
  poison,
  fire,
  flying,
  water,
  bug,
  normal,
  electric,
  ground,
  fairy,
  fighting,
  psychic,
  rock,
  steel,
  ice,
  ghost,
  dragon,
  dark,
  unknown
}

extension PokemonTypesX on PokemonTypes {
  String get value => getEnumValue(this).capitalize();

  static PokemonTypes parse(String rawValue) {
    final type = PokemonTypes.values.firstWhere(
      (element) => element.value.toLowerCase() == rawValue.toLowerCase(),
      orElse: () => PokemonTypes.unknown,
    );

    return type;
  }
}
