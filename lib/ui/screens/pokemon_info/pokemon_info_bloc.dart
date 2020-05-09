import 'package:injectable/injectable.dart';

import '../../../core/bloc.dart';
import '../../../core/bloc_state.dart';
import '../../../domain/entities/pokemon.dart';

part 'blocs/current_pokemon.dart';

@injectable
class PokemonInfoBloc extends Bloc {
  final _CurrentPokemon currentPokemon = _CurrentPokemon();

  @override
  void dispose() {
    currentPokemon.dispose();
  }
}
