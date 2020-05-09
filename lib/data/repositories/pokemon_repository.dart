import 'package:injectable/injectable.dart';

import '../../domain/entities/pokemon.dart';
import '../source/github/github_datasource.dart';
import '../source/local/local_datasource.dart';
import '../source/mappers/github_to_local_mapper.dart';
import '../source/mappers/local_to_entity_mapper.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemons({int limit, int page});
}

@LazySingleton(as: PokemonRepository)
class PokemonDefaultRepository extends PokemonRepository {
  PokemonDefaultRepository({this.githubDataSource, this.localDataSource});

  final GithubDataSource githubDataSource;
  final LocalDataSource localDataSource;

  @override
  Future<List<Pokemon>> getPokemons({int limit, int page}) async {
    final hasCachedData = await localDataSource.hasData();

    if (!hasCachedData) {
      final pokemonGithubModels = await githubDataSource.getPokemons();
      final pokemonHiveModels = pokemonGithubModels.map((e) => e.toHiveModel());

      await localDataSource.savePokemons(pokemonHiveModels);
    }

    final pokemonHiveModels = await localDataSource.getPokemons(
      page: page,
      limit: limit,
    );
    final pokemonEntities = pokemonHiveModels
        .where((element) => element != null)
        .map((e) => e.toEntity())
        .toList();

    return pokemonEntities;
  }
}
