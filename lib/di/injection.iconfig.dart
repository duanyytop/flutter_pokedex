// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:pokedex/routes.dart';
import 'package:pokedex/ui/screens/home/home_bloc.dart';
import 'package:pokedex/data/source/local/local_datasource.dart';
import 'package:pokedex/core/network.dart';
import 'package:pokedex/ui/screens/pokemon_info/pokemon_info_bloc.dart';
import 'package:pokedex/data/source/github/github_datasource.dart';
import 'package:pokedex/data/repositories/pokemon_repository.dart';
import 'package:pokedex/domain/usecases/pokemon_usecases.dart';
import 'package:pokedex/ui/screens/pokedex/pokedex_bloc.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerLazySingleton<AppNavigator>(() => AppNavigator());
  g.registerFactory<HomeBloc>(() => HomeBloc());
  g.registerLazySingleton<LocalDataSource>(() => LocalDataSource());
  g.registerLazySingleton<NetworkManager>(() => NetworkManager());
  g.registerFactory<PokemonInfoBloc>(() => PokemonInfoBloc());
  g.registerLazySingleton<GithubDataSource>(
      () => GithubDataSource(g<NetworkManager>()));
  g.registerLazySingleton<PokemonRepository>(() => PokemonDefaultRepository(
      githubDataSource: g<GithubDataSource>(),
      localDataSource: g<LocalDataSource>()));
  g.registerLazySingleton<GetPokemonsUseCase>(
      () => GetPokemonsUseCase(g<PokemonRepository>()));
  g.registerFactory<PokedexBloc>(() => PokedexBloc(g<GetPokemonsUseCase>()));
}
