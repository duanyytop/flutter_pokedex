import 'package:injectable/injectable.dart';

import '../../core/usecase.dart';
import '../../data/repositories/pokemon_repository.dart';
import '../entities/pokemon.dart';

class GetPokemonParams {
  final int page;
  final int limit;

  const GetPokemonParams({this.page, this.limit});
}

@LazySingleton()
class GetPokemonsUseCase extends UseCase<List<Pokemon>, GetPokemonParams> {
  final PokemonRepository repository;

  const GetPokemonsUseCase(this.repository);

  @override
  Future<List<Pokemon>> call(GetPokemonParams params) {
    return repository.getPokemons(page: params.page, limit: params.limit);
  }
}
