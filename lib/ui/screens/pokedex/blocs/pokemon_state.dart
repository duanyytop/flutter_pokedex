part of '../pokedex_bloc.dart';

class _PokemonBlocState extends BlocState<FetchState> {
  _PokemonBlocState() : super(defaultValue: InitialState());

  List<Pokemon> pokemons = [];
  bool loading = false;
  int page = 1;

  void onLoadStart({@required bool reset}) {
    if (reset) {
      pokemons.clear();
      page = 1;
    }

    loading = true;
  }

  void onLoadFinish(List<Pokemon> newPokemons, {@required bool reset}) {
    if (reset) {
      add(InitialState());
    }

    if (newPokemons.isNotEmpty) {
      pokemons.addAll(newPokemons);
      page += 1;
      add(SuccessState(pokemons, canLoadMore: true));
    } else if (pokemons.isNotEmpty) {
      add(SuccessState(pokemons, canLoadMore: false));
    } else {
      add(EmptyState());
    }

    loading = false;
  }

  void onLoadError(Exception e) {
    add(ErrorState(e));

    loading = false;
  }
}
