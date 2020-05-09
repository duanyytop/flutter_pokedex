import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/bloc.dart';
import '../../../core/bloc_state.dart';
import '../../../core/fetch_state.dart';
import '../../../domain/entities/pokemon.dart';
import '../../../domain/usecases/pokemon_usecases.dart';

part 'blocs/fab_menu.dart';
part 'blocs/pokemon_state.dart';

@injectable
class PokedexBloc extends Bloc {
  PokedexBloc(this._getPokemonsUseCase);

  final GetPokemonsUseCase _getPokemonsUseCase;

  final _FabMenuBlocState fabMenu = _FabMenuBlocState();
  final _PokemonBlocState pokemonState = _PokemonBlocState();

  @override
  void dispose() {
    fabMenu.dispose();
    pokemonState.dispose();
  }

  Future getPokemons({bool reset = false}) async {
    try {
      pokemonState.onLoadStart(reset: reset);

      final newPokemons = await _getPokemonsUseCase(GetPokemonParams(
        page: pokemonState.page,
        limit: 20,
      ));

      pokemonState.onLoadFinish(newPokemons, reset: reset);
    } on Exception catch (e) {
      pokemonState.onLoadError(e);
    }
  }
}
